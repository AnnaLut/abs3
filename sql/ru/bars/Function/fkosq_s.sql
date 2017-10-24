
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fkosq_s.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FKOSQ_S (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
kv_     INTEGER;
BEGIN
     BEGIN
	  SELECT kv   INTO kv_   FROM accounts 	  WHERE acc=acc_;
          EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
	 END;
 	   IF kv_=980 THEN
	     BEGIN
		    SELECT sum(kos)
			INTO nn_
			FROM  saldoa
			WHERE acc  =  acc_   AND
			      fdat >= fdat1_ AND
				  fdat <= fdat2_ ;
	 	    IF nn_ IS NULL THEN nn_:=0; END IF;
		 END;
       ELSE
		 BEGIN
		    SELECT sum(kos)
			INTO nn_
			FROM  saldob
			WHERE acc  =  acc_   AND
			      fdat >= fdat1_ AND
				  fdat <= fdat2_ ;
	 	    IF nn_ IS NULL THEN nn_:=0; END IF;
  		 END;
	   END IF;
   RETURN nn_;
END FKOSQ_S;
/
 show err;
 
PROMPT *** Create  grants  FKOSQ_S ***
grant EXECUTE                                                                on FKOSQ_S         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FKOSQ_S         to START1;
grant EXECUTE                                                                on FKOSQ_S         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fkosq_s.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 