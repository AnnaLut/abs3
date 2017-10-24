
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/krs840.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KRS840 (kv_ smallint,dat_ DATE)
	return NUMBER
IS
	kurs_ NUMBER;
BEGIN
	IF kv_=980 THEN
   		SELECT bsum/rate_o INTO kurs_
   		FROM cur_rates
   		WHERE vdate=dat_ AND kv=840 ;
	ELSE
   		SELECT (a.rate_o*a.bsum)/b.rate_o/b.bsum INTO kurs_
   		FROM cur_rates a, cur_rates b
   		WHERE a.vdate=dat_ AND b.vdate=dat_ AND b.kv=840 AND a.kv=kv_;
	END IF;

RETURN kurs_;

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/krs840.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 