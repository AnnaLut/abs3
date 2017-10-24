
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_new.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_NEW 
                 ( kod_ INTEGER,   -- код тарифа
                   kv_  INTEGER,   -- валюта операции
                   nls_ VARCHAR2,  -- бух.номер счета
                   s_   NUMERIC,   -- сумма операции
                   kvk_ number default 0)  -- =1 - сумма тарифа в базовой валюте
-----------------------------------------------------------------------------

-- Тарифы "по ШКАЛЕ" допускают только "Тип" = 1,2,3,4:
-- ---------------------------------------------------
-- Тип=1 - От суммы. Работает как ОБЩИЙ.
--    =2 - От суммы. Работает как ИНДИВИДУАЛЬНЫЙ - счет должен быть в ACC_TARIF.
--    =3 - От кол.платежей за истекший месяц  ("АЖИО").
--                   Работает как ИНДИВИДУАЛЬНЫЙ - счет должен быть в ACC_TARIF.
--    =4 - От среднего остатка по счету за прошлый месяц ("Демарк").
--                   Работает как ИНДИВИДУАЛЬНЫЙ - счет должен быть в ACC_TARIF.
--
--  ВНИМАНИЕ !      Тарифы "по шкале" типов 2,3,4 работают только для тех
--  счетов, для которых он выставлен как индивидуальный, т.е. счет с этим
--  тарифом должен обязательно быть в ACC_TARIF.
--  Тип=1 - работает как ОБЩИЙ - наличие в ACC_TARIF не обязательно.
------------------------------------------------------------------------------

RETURN NUMERIC IS
 nkv_ NUMERIC ;  -- нац.валюта
 bkv_ NUMERIC ;  -- базовая валюта тарифа
 so_  NUMERIC ;  -- сумма операции в базовой валюте
 min_ NUMERIC ;  -- минимально допустимая сумма комиссии
 max_ NUMERIC ;  -- максимально допустимая сумма комиссии
 sk_  NUMERIC ;  -- расчетная сумма комиссии
 tip_ NUMBER;    -- тип тарифа: 0 - простая, 1 - шкала

BEGIN

  nkv_:=gl.BASEVAL ;
  BEGIN
     -- Поиск кода базовой валюты, "общих" граничных значений и
     -- определение ТИПА тарифа: 0 - простой, 1 - по шкале:
     SELECT kv,   nvl(tip,0), smin, smax
     INTO   bkv_, tip_,       min_, max_
     FROM  v_tarif
     WHERE kod=kod_ ;

  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0 ;
  END ;

  -- перевод суммы операции в базовую валюту (через нац.валюту)

  so_ := s_;

  IF bkv_ <> kv_ THEN
      -- переводим в нац.валюту
      IF kv_<> nkv_ THEN
         so_ := gl.p_icurval(kv_, s_, gl.bd) ;
      END IF;
      -- базовая валюта HE нац.валюта, переводим в базовую
      IF bkv_ <> nkv_ THEN
         so_ := gl.p_ncurval(bkv_,so_,gl.bd);
      END IF;
  END IF;

----------------------------------------------------------------------

  IF tip_ = 0 THEN         -- Обычный тариф ( не шкальный )

     sk_ := NULL ;

     -- Если тариф индивидуальный:
     BEGIN
       SELECT ta.smin, nvl(ta.tar,0) + SO_* nvl(ta.pr,0)/100, ta.smax
       INTO   min_ , sk_ , max_
       FROM acc_tarif ta, accounts a
       WHERE a.kv   = kv_    AND
             a.nls  = nls_   AND
             a.acc  = ta.acc AND
             ta.kod = kod_   AND
             trunc(gl.bdate,'dd')>=decode(ta.bdate,null,trunc(gl.bdate,'dd'),ta.bdate) AND
             trunc(gl.bdate,'dd')<=decode(ta.edate,null,trunc(gl.bdate,'dd'),ta.edate) ;
     EXCEPTION WHEN NO_DATA_FOUND THEN sk_ := NULL ;
     END;


     -- Если нет индивидуального - берем общий:
     IF sk_ IS NULL THEN
        BEGIN
          SELECT  nvl(t.tar,0) + SO_* nvl(t.pr,0)/100
          INTO    sk_
          FROM  v_tarif t
          WHERE t.kod=kod_ ;
        EXCEPTION WHEN NO_DATA_FOUND THEN sk_ := NULL ;
        END;
     END IF;

     -- Учет ГРАНИЧНЫХ значений   и
     -- перевод суммы комиссии в валюту операции (через нац.валюту)
     IF sk_ IS NULL THEN
        -- отсутст.тариф по коду kod_
        sk_ := 0 ;
     ELSE

        IF max_=0 THEN
           max_:= NULL;
        END IF;

        sk_ := iif_n(sk_, min_, min_,min_,sk_) ;
        sk_ := iif_n(max_,sk_,  max_,max_,sk_) ;

        IF bkv_ <> kv_ THEN
           -- если задано kvk_=1, возвращаем сумму тарифа в базовой валюте
           if kvk_ = 1 then
              return sk_;
           end if;
           -- базовая валюта HE нац.валюта, переводим в нац.валюту
           IF bkv_<> nkv_ THEN
              sk_ := gl.p_icurval(bkv_,sk_,gl.bd ) ;
           END IF;
           -- валюта счета HE нац.валюта, переводим в валюту счета
           IF kv_ <> gl.BASEVAL THEN
              sk_:=gl.p_ncurval(kv_, sk_,gl.bd );
           END IF;
        END IF;
     END IF;


  ELSE    -----------   tip_ >0    -  по ШКАЛЕ !!!     --------------


    --  Вначале, переменная S0_  -  это сумма документа.
    --  Для tip_ =3,4 идет подмена на Аcc_tarif.NDOK_RKO или OST_AVG:

     IF tip_ =1    then --  tip_=1 - тариф по шкале от СУММЫ ДОК., как ОБЩИЙ !

        NULL;

     ELSIF tip_ =2 then --  tip_=2 - тариф по шкале от СУММЫ ДОК., обяз.как
                        --           индивидуальный.
                        --           Наличие счета в ACC_TARIF обязательно !
        BEGIN
          SELECT t.tip INTO tip_    -- для проверки наличия записи acc_tarif с 1
            FROM v_tarif t, ACC_TARIF ta, accounts a
           WHERE a.acc = ta.acc AND t.kod  =ta.kod  AND t.kod = kod_
             AND nvl(ta.PR,0) + nvl(ta.TAR,0) > 0
             AND a.nls = nls_  AND a.kv = kv_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;


     ELSIF tip_ =3 then  --  tip_=3 - тариф по шкале от КОЛ.ДОК.
                         --  за истекший месяц.   ("АЖИО")
                         --  Подменяем S0_ на Аcc_tarif.NDOK_RKO
                         --  Наличие счета в ACC_TARIF обязательно !
        BEGIN
          SELECT t.NDOK_RKO INTO so_
            FROM ACC_TARIF t, accounts a
           WHERE a.acc = t.acc AND t.kod = kod_
             AND nvl(t.PR,0) + nvl(t.TAR,0) > 0
             AND a.nls = nls_  AND a.kv = kv_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;



     ELSIF tip_ =4  then  --  "Демарк":  tip_=4  - тариф по шкале
                          --  от CРЕДНЕГО ОСТАТКА по счету за прошлый месяц.
                          --  Подменяем S0_  на Аcc_tarif.OST_AVG
                          --  Наличие счета в ACC_TARIF обязательно !
        BEGIN
          SELECT t.ost_avg INTO so_
            FROM acc_tarif t, accounts a
           WHERE a.acc = t.acc AND t.kod = kod_
             AND nvl(t.PR,0) + nvl(t.TAR,0) > 0
             AND a.nls = nls_  AND a.kv = kv_;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSE               --  при всех остальных tip_  -  RETURN 0

        RETURN 0;

     END IF;

     ---------------------------

     -- Расчет комиссии по шкале :
     IF so_ IS NULL THEN              -- если so_ is NULL
        SELECT t.sum_tarif INTO sk_
          FROM tarif_scale t
         WHERE t.kod = kod_ AND t.sum_limit = 0;
     ELSE
       BEGIN
         SELECT nvl(t.sum_tarif,0) + so_*nvl(t.pr,0)/100 INTO sk_
           FROM tarif_scale t
          WHERE t.kod = kod_ AND
                t.sum_limit =
                             (SELECT min(sum_limit) FROM tarif_scale
                               WHERE kod = t.kod AND sum_limit >= so_);
       EXCEPTION
         WHEN NO_DATA_FOUND THEN sk_ := NULL ;
       END;
     END IF;


     -- Учет ГРАНИЧНЫХ значений   и
     -- перевод суммы комиссии в валюту операции (через нац.валюту)
     IF sk_ IS NULL THEN
        -- отсутст.тарифы по коду kod_
        sk_ := 0 ;
     ELSE

        IF max_=0 THEN
           max_:= NULL;
        END IF;

        sk_ := iif_n(sk_, min_, min_,min_,sk_) ;
        sk_ := iif_n(max_,sk_,  max_,max_,sk_) ;

        IF bkv_ <> kv_ THEN
           -- если задано kvk_=1, возвращаем сумму тарифа в базовой валюте
           if kvk_ = 1 then
              return sk_;
           end if;
           -- базовая валюта HE нац.валюта, переводим в нац.валюту
           IF bkv_<> nkv_ THEN
              sk_ := gl.p_icurval(bkv_,sk_,gl.bd ) ;
           END IF;
           -- валюта счета HE нац.валюта, переводим в валюту счета
           IF kv_ <> gl.BASEVAL THEN
              sk_:=gl.p_ncurval(kv_, sk_,gl.bd );
           END IF;
        END IF;
     END IF;

  END IF;

  RETURN sk_;

END F_TARIF_NEW ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_NEW ***
grant EXECUTE                                                                on F_TARIF_NEW     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_NEW     to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_new.sql =========*** End **
 PROMPT ===================================================================================== 
 