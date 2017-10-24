
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_315.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_315 (kv_ INTEGER, ss_ number)
RETURN VARCHAR2 IS
sn_ number(24);
BEGIN
  SELECT DISTINCT ss_*(RATE_B/bsum)
  into sn_
  FROM  cur_rates
  WHERE vdate = ( SELECT MAX (vdate)
                    FROM cur_rates
                   WHERE vdate <= bankdate AND
                         kv = kv_ and
                         rate_b <> 0)
        AND kv = kv_ and rate_b <> 0 ;
RETURN sn_;
END F_315;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_315.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 