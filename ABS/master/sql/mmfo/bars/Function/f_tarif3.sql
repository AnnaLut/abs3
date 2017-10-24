
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif3.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF3 
                 ( ref_ NUMBER )   -- референс документа
RETURN NUMERIC IS
 min_ 	NUMERIC ;  -- минимально допустимая сумма комиссии
 max_ 	NUMERIC ;  -- максимально допустимая сумма комиссии
 sk_  	NUMERIC ;  -- расчетная сумма комиссии
 kod_   INTEGER ;  -- код тарифа
 s_     NUMBER  ;  -- сумма платежа
 rnk_   INTEGER ;  -- РНК контрагента
 nlsa_  varchar2(15) ;    -- счет А
 kv_    number;           -- вал А

BEGIN

  sk_  := 0 ;
  kod_ := 0 ;

  SELECT s INTO s_ FROM oper WHERE ref=ref_;

  SELECT rnk,  nls,   kv
    INTO rnk_, nlsa_, kv_
    FROM accounts
    WHERE nls IN (SELECT nlsa FROM oper WHERE ref=ref_)
      AND kv  IN (SELECT kv   FROM oper WHERE ref=ref_);

  IF rnk_ IN (916591,907073,907006) THEN -- УКРПОШТА
    kod_ := 78;
  ELSE
    kod_ := 3;
  END IF;

  SELECT F_TARIF( kod_, kv_, nlsa_, s_ ) into sk_ from dual;

  RETURN sk_;

END f_tarif3 ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif3.sql =========*** End *** =
 PROMPT ===================================================================================== 
 