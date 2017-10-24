
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF (
  kod_ INTEGER,              -- код тарифа
  kv_  INTEGER,              -- валюта операции
  nls_ VARCHAR2,             -- бух.номер счета
  s_   NUMERIC,              -- сумма операции
  kvk_ number default 0,     -- =1 - сумма тарифа в базовой валюте
  dat_ date   default null ) -- дата, на которую берется тариф, null=gl.bdate
-------------------------------------------------------------------------------
-- version 3.1 05.01.2015
-------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------

RETURN NUMERIC IS

  l_nkv   NUMERIC;  -- нац.валюта
  l_so    NUMERIC;  -- сумма операции в базовой валюте
  l_sk    NUMERIC;  -- расчетная сумма комиссии
  l_tarif v_tarif%rowtype;
  l_acc   number;
  l_dat   date;

-- перевод суммы в базовую валюту (через нац.валюту)
function s_to_bkv (p_s number, p_kv number, p_bkv number) return number
is
  l_s number;
begin
  l_s := p_s;
  if p_bkv <> p_kv THEN
     -- переводим в нац.валюту
     if p_kv <> l_nkv THEN
        l_s := gl.p_icurval(p_kv, l_s, gl.bd);
     end if;
     -- базовая валюта HE нац.валюта, переводим в базовую
     if p_bkv <> l_nkv THEN
        l_s := gl.p_ncurval(p_bkv, l_s, gl.bd);
     end if;
  end if;
  return l_s;
end;

BEGIN

  l_nkv := gl.BASEVAL;

  l_dat := dat_;
  if l_dat is null then l_dat := trunc(gl.bdate,'dd'); end if;

  -- Поиск кода базовой валюты, "общих" граничных значений и
  -- определение ТИПА тарифа: 0 - простой, 1 - по шкале:
  begin
     select * into l_tarif from v_tarif where kod = kod_;
  exception when no_data_found then return 0;
  end ;
  l_tarif.tip     := nvl(l_tarif.tip,0);
  l_tarif.tar     := nvl(l_tarif.tar,0);
  l_tarif.pr      := nvl(l_tarif.pr,0);
  l_tarif.kv_smin := nvl(l_tarif.kv_smin,l_tarif.kv);
  l_tarif.kv_smax := nvl(l_tarif.kv_smax,l_tarif.kv);

  if l_dat < nvl(l_tarif.dat_begin,l_dat)
  or l_dat > nvl(l_tarif.dat_end,  l_dat) then
     bars_error.raise_nerror('DOC', 'TARIF_DAT', kod_);
  end if;

  -- перевод суммы операции в базовую валюту (через нац.валюту)
  l_so := s_;
  IF l_tarif.kv <> kv_ THEN
     l_so := s_to_bkv(l_so, kv_, l_tarif.kv);
  END IF;

  begin
     select acc into l_acc
       from accounts
      where nls = nls_ and kv = kv_;
  exception when no_data_found then
     l_acc := null;
  end;

----------------------------------------------------------------------

  IF l_tarif.tip = 0 THEN         -- Обычный тариф ( не шкальный )

     l_sk := null;

     -- Если тариф индивидуальный:
     BEGIN
        SELECT nvl(ta.tar,0) + l_so * nvl(ta.pr,0)/100, ta.smin, ta.smax
          INTO l_sk, l_tarif.smin, l_tarif.smax
          FROM acc_tarif ta
         WHERE ta.acc = l_acc
           and ta.kod = kod_
           and l_dat >= decode(ta.bdate,null,l_dat,ta.bdate)
           and l_dat <= decode(ta.edate,null,l_dat,ta.edate);
        -- ??? для инд.тарифов граничная сумма указывается в базовой валюте тарифа
        l_tarif.kv_smin := l_tarif.kv;
        l_tarif.kv_smax := l_tarif.kv;
     EXCEPTION WHEN NO_DATA_FOUND THEN l_sk := null;
     END;

     -- Если нет индивидуального - берем общий:
     IF l_sk IS NULL THEN
        if l_acc is not null then
           BEGIN
              SELECT nvl(t.tar,0) + l_so* nvl(t.pr,0)/100, smin, smax
                INTO l_sk, l_tarif.smin, l_tarif.smax
                FROM v_acc_tarif t
               WHERE t.acc = l_acc
                 and t.kod = kod_ ;
           EXCEPTION WHEN NO_DATA_FOUND THEN l_sk := null;
           END;
        else
           l_sk := l_tarif.tar + l_so * l_tarif.pr/100;
        end if;
     END IF;

     -- Учет ГРАНИЧНЫХ значений   и
     -- перевод суммы комиссии в валюту операции (через нац.валюту)
     IF l_sk IS NULL THEN
        -- отсутст.тариф по коду kod_
        l_sk := 0;
     ELSE

        IF l_tarif.smax = 0 THEN
           l_tarif.smax := null;
        END IF;

        -- перевод граничной суммы в базовую валюту (через нац.валюту)
        IF l_tarif.kv <> l_tarif.kv_smin THEN
           l_tarif.smin := s_to_bkv(l_tarif.smin, l_tarif.kv_smin, l_tarif.kv);
        END IF;
        IF l_tarif.kv <> l_tarif.kv_smax and l_tarif.smax is not null THEN
           l_tarif.smax := s_to_bkv(l_tarif.smax, l_tarif.kv_smax, l_tarif.kv);
        END IF;

        l_sk := iif_n(l_sk, l_tarif.smin, l_tarif.smin, l_tarif.smin, l_sk);
        l_sk := iif_n(l_tarif.smax, l_sk, l_tarif.smax, l_tarif.smax, l_sk);

        IF l_tarif.kv <> kv_ THEN
           -- если задано kvk_=1, возвращаем сумму тарифа в базовой валюте
           if kvk_ = 1 then
              return l_sk;
           end if;
           -- базовая валюта HE нац.валюта, переводим в нац.валюту
           IF l_tarif.kv <> l_nkv THEN
              l_sk := gl.p_icurval(l_tarif.kv, l_sk, gl.bd);
           END IF;
           -- валюта счета HE нац.валюта, переводим в валюту счета
           IF kv_ <> gl.BASEVAL THEN
              l_sk := gl.p_ncurval(kv_, l_sk, gl.bd);
           END IF;
        END IF;
     END IF;


  ELSE    -----------   tip >0    -  по ШКАЛЕ !!!     --------------


     --  Вначале, переменная S0_  -  это сумма документа.
     --  Для tip =3,4 идет подмена на Аcc_tarif.NDOK_RKO или OST_AVG:

     IF l_tarif.tip = 1    then --  tip=1 - тариф по шкале от СУММЫ ДОК., как ОБЩИЙ !

        NULL;

     ELSIF l_tarif.tip = 2 then --  tip=2 - тариф по шкале от СУММЫ ДОК., обяз.как
                                --                  индивидуальный.
                                --                  Наличие счета в ACC_TARIF обязательно !
        BEGIN
           SELECT t.tip INTO l_tarif.tip    -- для проверки наличия записи acc_tarif с 1
             FROM v_tarif t, ACC_TARIF ta
            WHERE ta.acc = l_acc
              AND t.kod  = ta.kod
              AND t.kod  = kod_
              AND nvl(ta.PR,0) + nvl(ta.TAR,0) > 0;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSIF l_tarif.tip = 3 then  --  tip=3 - тариф по шкале от КОЛ.ДОК.
                                 --  за истекший месяц.   ("АЖИО")
                                 --  Подменяем S0_ на Аcc_tarif.NDOK_RKO
                                 --  Наличие счета в ACC_TARIF обязательно !
        BEGIN
           SELECT t.NDOK_RKO INTO l_so
             FROM ACC_TARIF t
            WHERE t.acc = l_acc
              AND t.kod = kod_
              AND nvl(t.PR,0) + nvl(t.TAR,0) > 0;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSIF l_tarif.tip = 4  then  --  "Демарк":  tip=4  - тариф по шкале
                                  --  от CРЕДНЕГО ОСТАТКА по счету за прошлый месяц.
                                  --  Подменяем S0_  на Аcc_tarif.OST_AVG
                                  --  Наличие счета в ACC_TARIF обязательно !
        BEGIN
           SELECT t.ost_avg INTO l_so
             FROM acc_tarif t
            WHERE t.acc = l_acc
              AND t.kod = kod_
              AND nvl(t.PR,0) + nvl(t.TAR,0) > 0;
        EXCEPTION
           WHEN NO_DATA_FOUND THEN RETURN 0;
        END;

     ELSE                         --  при всех остальных tip  -  RETURN 0

        RETURN 0;

     END IF;

     ---------------------------

     -- Расчет комиссии по шкале :
     IF l_so IS NULL THEN              -- если l_so is NULL
        SELECT t.sum_tarif, t.smin, t.smax INTO l_sk, l_tarif.smin, l_tarif.smax
          FROM v_acc_tarif_scale t
         WHERE t.acc = l_acc
           and t.kod = kod_ AND t.sum_limit = 0;
     ELSE
        BEGIN
           SELECT nvl(t.sum_tarif,0) + l_so*nvl(t.pr,0)/100, t.smin, t.smax INTO l_sk, l_tarif.smin, l_tarif.smax
             FROM v_acc_tarif_scale t
            WHERE t.acc = l_acc
              and t.kod = kod_ AND
                  t.sum_limit = ( SELECT min(sum_limit)
                                    FROM v_acc_tarif_scale
                                   WHERE acc = t.acc
                                     and kod = t.kod AND sum_limit >= l_so );
        EXCEPTION
           WHEN NO_DATA_FOUND THEN l_sk := NULL ;
        END;
     END IF;

     -- Учет ГРАНИЧНЫХ значений   и
     -- перевод суммы комиссии в валюту операции (через нац.валюту)
     IF l_sk IS NULL THEN
        -- отсутст.тарифы по коду kod_
        l_sk := 0 ;
     ELSE

        IF l_tarif.smax = 0 THEN
           l_tarif.smax := NULL;
        END IF;

        -- перевод граничной суммы в базовую валюту (через нац.валюту)
        IF l_tarif.kv <> l_tarif.kv_smin THEN
           l_tarif.smin := s_to_bkv(l_tarif.smin, l_tarif.kv_smin, l_tarif.kv);
        END IF;
        IF l_tarif.kv <> l_tarif.kv_smax and l_tarif.smax is not null THEN
           l_tarif.smax := s_to_bkv(l_tarif.smax, l_tarif.kv_smax, l_tarif.kv);
        END IF;

        l_sk := iif_n(l_sk, l_tarif.smin, l_tarif.smin, l_tarif.smin, l_sk);
        l_sk := iif_n(l_tarif.smax, l_sk, l_tarif.smax, l_tarif.smax, l_sk);

        IF l_tarif.kv <> kv_ THEN
           -- если задано kvk_=1, возвращаем сумму тарифа в базовой валюте
           if kvk_ = 1 then
              return l_sk;
           end if;
           -- базовая валюта HE нац.валюта, переводим в нац.валюту
           IF l_tarif.kv<> l_nkv THEN
              l_sk := gl.p_icurval(l_tarif.kv,l_sk,gl.bd ) ;
           END IF;
           -- валюта счета HE нац.валюта, переводим в валюту счета
           IF kv_ <> gl.BASEVAL THEN
              l_sk:=gl.p_ncurval(kv_, l_sk,gl.bd );
           END IF;
        END IF;

     END IF;

  END IF;

  RETURN l_sk;

END f_tarif ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF ***
grant EXECUTE                                                                on F_TARIF         to ABS_ADMIN;
grant DEBUG,EXECUTE                                                          on F_TARIF         to BARS009;
grant EXECUTE                                                                on F_TARIF         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF         to OPERKKK;
grant EXECUTE                                                                on F_TARIF         to PYOD001;
grant EXECUTE                                                                on F_TARIF         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 