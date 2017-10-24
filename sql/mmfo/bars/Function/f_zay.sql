
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zay.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAY (rnk_ INTEGER, kv_ NUMBER, datz_ DATE, contract_ VARCHAR2)
RETURN DECIMAL IS
sum_     NUMBER;
s_nal    NUMBER;
s_opl    NUMBER;
dat1_    DATE;
BEGIN
 IF contract_ IS NOT NULL  THEN
   BEGIN
        -- сколько данной валюты можно было купить
	-- согласно справке от НИ по данному контракту
	SELECT min(nal_date), nvl(sum(s),0) INTO dat1_, s_nal FROM cust_nal
    WHERE rnk=rnk_ AND contract=contract_ AND kv=kv_ AND nal_date<=datz_;
    EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
   END;
   -- сколько реально было куплено по данному контракту валюты
   BEGIN
    SELECT nvl(sum(o.s),0) INTO s_opl
	FROM opldok o, zayavka z
    WHERE o.fdat>=dat1_ AND o.fdat<= datz_ AND o.ref=z.ref AND
	      o.dk=1 AND z.kv2=kv_ AND z.rnk=rnk_ AND z.acc1=o.acc AND
          z.dk=1 AND z.sos=2 AND o.sos>0 AND z.contract=contract_;
    EXCEPTION WHEN NO_DATA_FOUND THEN s_opl:=0;
   END;
   sum_:=s_nal-s_opl;
   RETURN sum_;
  ELSE --- нет контракта!!!
   BEGIN
    SELECT min(nal_date), nvl(sum(s),0) INTO dat1_, s_nal FROM cust_nal
    WHERE rnk=rnk_ AND kv=kv_ AND nal_date<=datz_ AND contract IS NULL;
    EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN  NULL;
   END;
   BEGIN
    SELECT nvl(sum(o.s),0) INTO s_opl
	FROM opldok o, zayavka z
    WHERE o.fdat>=dat1_ AND o.fdat<= datz_ AND o.ref=z.ref AND
	  o.dk=1        AND z.kv2=kv_      AND z.rnk=rnk_  AND
          z.acc1=o.acc  AND z.dk=1         AND z.sos=2     AND
          o.sos>0       AND z.contract IS NULL ;
    EXCEPTION WHEN NO_DATA_FOUND THEN s_opl:=0;
   END;
   sum_:=s_nal-s_opl;
   RETURN sum_;
END IF;
END F_ZAY;
 
/
 show err;
 
PROMPT *** Create  grants  F_ZAY ***
grant EXECUTE                                                                on F_ZAY           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ZAY           to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_ZAY           to ZAY;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_zay.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 