
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_zaynal.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ZAYNAL 
    (rnk_      NUMBER,
     kv_       NUMBER,
     datz_     DATE,
     pid_      NUMBER,
     contract_ VARCHAR2)
RETURN DECIMAL IS
  sum_          NUMBER;
  s_nal_        NUMBER;
  s_opl_        NUMBER;
  dat1_         DATE;
  control_days_ NUMBER;
BEGIN
-- ============================================================================
--                Модуль "Биржевые операции"
--           Расчет "резерва" валюты для покупки клиентом
--           согласно импортного контракта и справкам из НИ
-- ============================================================================
 BEGIN
   SELECT to_number(val) INTO control_days_
     FROM birja
    WHERE par='NAL_SROK' AND val IS NOT NULL;
 EXCEPTION WHEN NO_DATA_FOUND THEN control_days_:=90;
 END;

 IF pid_ IS NOT NULL THEN

    -- сколько данной валюты можно было купить
    -- согласно АКТУАЛЬНОЙ справке от НИ по данному контракту
    BEGIN
      SELECT min(nal_date), nvl(sum(s),0)
        INTO dat1_, s_nal_
        FROM cust_nal
       WHERE rnk=rnk_
         AND pid=pid_
         AND kv=kv_
         AND datz_ BETWEEN nal_date AND nal_date+control_days_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      RETURN NULL;
    END;

    -- сколько реально было куплено по данному контракту валюты
    BEGIN
      SELECT nvl(sum(o.s),0)
        INTO s_opl_
        FROM opldok o, zayavka z
       WHERE o.fdat>=dat1_        AND o.fdat<= datz_ AND o.ref=z.ref  AND
             o.dk=1 AND z.kv2=kv_ AND z.rnk=rnk_     AND z.acc1=o.acc AND
             z.dk=1 AND z.sos=2   AND o.sos>0        AND z.pid=pid_;
    EXCEPTION WHEN NO_DATA_FOUND THEN s_opl_:=0;
    END;

    sum_:=s_nal_-s_opl_;

    RETURN sum_;

 ELSIF contract_ IS NOT NULL THEN

   BEGIN
     SELECT min(nal_date), nvl(sum(s),0)
       INTO dat1_, s_nal_
       FROM cust_nal
      WHERE rnk=rnk_
        AND kv=kv_
        AND contract=contract_
        AND datz_ BETWEEN nal_date AND nal_date+control_days_;
   EXCEPTION WHEN NO_DATA_FOUND THEN RETURN NULL;
   END;

   BEGIN
     SELECT nvl(sum(o.s),0)
       INTO s_opl_
       FROM opldok o, zayavka z
      WHERE o.fdat>=dat1_        AND o.fdat<= datz_ AND o.ref=z.ref  AND
            o.dk=1 AND z.kv2=kv_ AND z.rnk=rnk_     AND z.acc1=o.acc AND
            z.dk=1 AND z.sos=2   AND o.sos>0        AND z.contract=contract_;
   EXCEPTION WHEN NO_DATA_FOUND THEN s_opl_:=0;
   END;

   sum_:=s_nal_-s_opl_;

   RETURN sum_;

 ELSE --- нет контракта!!!

   BEGIN
     SELECT min(nal_date), nvl(sum(s),0)
       INTO dat1_, s_nal_
       FROM cust_nal
      WHERE rnk=rnk_
        AND kv=kv_
        AND datz_ BETWEEN nal_date AND nal_date+control_days_
        AND contract IS NULL
        AND pid IS NULL;
   EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN  NULL;
   END;

   BEGIN
     SELECT nvl(sum(o.s),0)
       INTO s_opl_
       FROM opldok o, zayavka z
      WHERE o.fdat>=dat1_ AND o.fdat<= datz_     AND o.ref=z.ref AND
            o.dk=1        AND z.kv2=kv_          AND z.rnk=rnk_  AND
            z.acc1=o.acc  AND z.dk=1             AND z.sos=2     AND
            o.sos>0       AND z.contract IS NULL AND z.pid IS NULL;
   EXCEPTION WHEN NO_DATA_FOUND THEN s_opl_:=0;
   END;

   sum_:=s_nal_-s_opl_;

   RETURN sum_;

 END IF;

END F_ZAYNAL;
/
 show err;
 
PROMPT *** Create  grants  F_ZAYNAL ***
grant EXECUTE                                                                on F_ZAYNAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ZAYNAL        to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_ZAYNAL        to ZAY;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_zaynal.sql =========*** End *** =
 PROMPT ===================================================================================== 
 