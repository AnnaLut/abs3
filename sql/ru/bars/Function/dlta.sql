
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dlta.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DLTA ( dk_ NUMBER, kv_ NUMBER, ost_ NUMBER, dos_ NUMBER, kos_ NUMBER, dat_ DATE ) RETURN NUMBER IS
delta_ NUMBER;
BEGIN
-- Вычисляет обороты в эквиваленте, с учетом переоценки

delta_:= gl.p_icurval(kv_, ost_, dat_)-gl.p_icurval(kv_, ost_+dos_-kos_, dat_-1)
        -gl.p_icurval(kv_, dos_, dat_)+gl.p_icurval(kv_, kos_, dat_);

RETURN
CASE WHEN dk_=0 AND delta_ < 0 THEN -delta_
     WHEN dk_=1 AND delta_ > 0 THEN +delta_
     ELSE 0 END
 +   CASE WHEN dk_=0 THEN gl.p_icurval(kv_, dos_, dat_) ELSE gl.p_icurval(kv_, kos_, dat_) END ;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dlta.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 