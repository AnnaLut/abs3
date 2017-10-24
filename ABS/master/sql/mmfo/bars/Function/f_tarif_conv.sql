
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tarif_conv.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TARIF_CONV (
  kod_ INTEGER,           -- код тарифа
  kv_  INTEGER,           -- валюта операции
  nls_ VARCHAR2,          -- бух.номер счета
  s_   NUMERIC   )        -- сумма операции

------------------------------------------------------------------
--  Суфтин Е.И. --
--
--  Формула сумы комиссии с конверсией, типа:
--
--    GL.P_ICURVAL(#(KVA), F_TARIF(122,#(KVA),#(NLSA),#(S)), SYSDATE )
--
--  работает неточно, если:
--    -   валюта тарифа НЕ совпадает с валютой операции;
--    -   тариф имеет граничные суммы SMIN,SMAX и значение тарифа
--        попадает за эти границы.
--
--  Вышеприведенную формулу надо заменить на:
--
--                    F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))
--
------------------------------------------------------------------

RETURN NUMERIC IS

  nkv_  NUMERIC;  -- нац.валюта
  bkv_  NUMERIC;  -- базовая валюта тарифа
  so_   NUMERIC;  -- сумма операции в базовой валюте
  min_  NUMERIC;  -- минимально допустимая сумма комиссии
  max_  NUMERIC;  -- максимально допустимая сумма комиссии
  sk_   NUMERIC;  -- расчетная сумма комиссии
  tip_  NUMBER;   -- тип тарифа: 0 - простая, 1 - шкала
  l_acc number;

BEGIN

  BEGIN
     -- Поиск кода базовой валюты и ограничительных сумм:
     SELECT kv,   nvl(smin,0), nvl(smax,0)
       INTO bkv_,     min_,        max_      ---  bkv_ - базовая валюта тарифа
       FROM v_tarif
      WHERE kod = kod_ ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     RETURN 0 ;
  END ;

  IF bkv_ <> kv_ and (min_ + max_)>0 then  -- Вал.операции <> БАЗОВОЙ вал.

     if F_TARIF(kod_,kv_,nls_,S_,1)=min_  or
        F_TARIF(kod_,kv_,nls_,S_,1)=max_       then

        sk_:=GL.P_ICURVAL(bkv_, F_TARIF(kod_,kv_,nls_,S_, 1), SYSDATE);
                                                         ---
     else

        sk_:=GL.P_ICURVAL(kv_, F_TARIF(kod_,kv_,nls_,S_), SYSDATE);

     end if;

  ELSE

    sk_:=GL.P_ICURVAL(kv_, F_TARIF(kod_,kv_,nls_,S_), SYSDATE);

  END IF;


  RETURN sk_;

END F_TARIF_CONV ;
/
 show err;
 
PROMPT *** Create  grants  F_TARIF_CONV ***
grant EXECUTE                                                                on F_TARIF_CONV    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TARIF_CONV    to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tarif_conv.sql =========*** End *
 PROMPT ===================================================================================== 
 