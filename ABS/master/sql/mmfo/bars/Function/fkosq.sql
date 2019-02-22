
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fkosq.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FKOSQ (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
kv_     INTEGER;
BEGIN
     BEGIN
	  SELECT kv
	  INTO kv_
	  FROM accounts
	  WHERE acc=acc_;
	 	EXCEPTION WHEN NO_DATA_FOUND THEN RETURN null;
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
			FROM  salb_fdat
			WHERE acc  =  acc_   AND
			      fdat >= fdat1_ AND
				  fdat <= fdat2_ ;
	 	    IF nn_ IS NULL THEN nn_:=0; END IF;
  		 END;
	   END IF;
   RETURN nn_;
END FKOSQ;

 
/
 show err;
 
PROMPT *** Create  grants  FKOSQ ***
grant EXECUTE                                                                on FKOSQ           to ABS_ADMIN;
grant EXECUTE                                                                on FKOSQ           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FKOSQ           to RPBN001;
grant EXECUTE                                                                on FKOSQ           to RPBN002;
grant EXECUTE                                                                on FKOSQ           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fkosq.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 