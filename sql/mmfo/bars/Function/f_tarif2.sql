
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif2.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF2 
                 ( ref_ NUMBER )   -- референс документа
RETURN NUMERIC IS
 min_ 	NUMERIC ;  -- минимально допустимая сумма комиссии
 max_ 	NUMERIC ;  -- максимально допустимая сумма комиссии
 sk_  	NUMERIC ;  -- расчетная сумма комиссии
 kod_   INTEGER ;  -- код тарифа
 tt_    oper.tt%type ;      -- код операции
 mfob_ 	oper.mfob%type ;    -- МФО банка-получателя
 s_     oper.s%type  ;      -- сумма платежа
 nlsa_  oper.nlsa%type;     -- номер счета плательщика
 nazn_  oper.nazn%type;     -- назначение платежа
 corp2flag_ NUMBER;    -- флаг удержания комиссии по операции IB2 (c физ.лиц)

BEGIN

  sk_  := 0 ;
  kod_ := 0 ;

  SELECT tt, nlsa, mfob, s, nazn INTO tt_, nlsa_, mfob_, s_, nazn_ FROM oper WHERE ref=ref_;

  SELECT to_number(trim(val),'9') INTO corp2flag_ FROM params WHERE par='CORP2KOM';

  -- проверим код операции
  -- ( если операция CORP2 и плательщик ЮЛ - комиссию не удерживаем )
  IF tt_ = 'IB2' AND substr(nlsa_,1,3) <> '262' THEN
    RETURN sk_;
  END IF;

  IF mfob_ like '8%' THEN
    -- налоги, сборы инвест.фондов
    kod_ := 31;
  ELSE
    BEGIN
      -- проверим код операции
      IF tt_ = 'IB2' AND substr(nlsa_,1,3) = '262' AND corp2flag_ = 1 THEN
        BEGIN
          -- если платеж по системе Ощадбанка, плательщик ФЛ и операция инициирована из CORP2 - комиссию не удерживаем
          -- в противном случае - удерживаем комиссию согласно тарифу
          SELECT 0 INTO kod_
            FROM banks_ob
           WHERE mfo=mfob_;
        EXCEPTION WHEN NO_DATA_FOUND THEN kod_ := 37 ;
        END;
      END IF;

      -- за погашение кредита, оплата начисленных %%
      IF (kod_ = 0) AND (tt_<>'IB2') THEN
        BEGIN
          SELECT 36 INTO kod_
            FROM banks_ob
           WHERE mfo=mfob_      -- платеж по системе Ощадбанка
             AND ( UPPER(nazn_) like '%ПОГАШ%' or
                   UPPER(nazn_) like '%КРЕДИТ%' or
                   UPPER(nazn_) like '%ПРОЦЕНТ%' or
                   UPPER(nazn_) like '%ВІДСОТ%' );
        EXCEPTION WHEN NO_DATA_FOUND THEN kod_ := 0 ;
        END;
      END IF;

      IF (kod_ = 0) AND (tt_<>'IB2') THEN
        -- платеж в пользу ЮР,ЛИЦ
        -- за товары, работы, услуги и проч.
       CASE
         -- выберем код тарифа в зависимости от суммы платежа
         WHEN s_ <= 100000                    THEN kod_ := 32;
         WHEN s_ >  100000  AND s_ <= 2500000 THEN kod_ := 33;
         WHEN s_ >  2500000 AND s_ <= 5000000 THEN kod_ := 34;
         WHEN s_ >  5000000                   THEN kod_ := 35;
       END CASE;
      END IF;
    END;
  END IF;

  -- вычислим сумму комиссии
  BEGIN
    SELECT t.smin, t.tar + S_* t.pr/100, t.smax
    INTO   min_  , sk_                  , max_
    FROM tarif t
    WHERE t.kod=kod_ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN sk_ := NULL ;
  END;

  -- учет ГРАНИЧНЫХ значений
  IF sk_ IS NULL THEN
    sk_ := 0 ; -- отсутст.тарифы по коду kod_
  ELSE
    sk_ := iif_n(sk_, min_, min_,min_,sk_) ;
    sk_ := iif_n(max_,sk_,  max_,max_,sk_) ;
  END IF;

  RETURN sk_;

END f_tarif2 ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif2.sql =========*** End *** =
 PROMPT ===================================================================================== 
 