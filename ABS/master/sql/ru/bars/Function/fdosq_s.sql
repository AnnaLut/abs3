
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fdosq_s.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FDOSQ_S (acc_ INTEGER, fdat1_ DATE, fdat2_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
kv_     INTEGER;
BEGIN
     BEGIN
	  SELECT kv   INTO kv_   FROM accounts
	  WHERE acc=acc_;
	 	EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
	 END;
 	   IF kv_=980 THEN
	     BEGIN
		    SELECT sum(dos)
			INTO nn_
			FROM  saldoa
			WHERE acc  =  acc_   AND  fdat >= fdat1_ AND
				                  fdat <= fdat2_ ;
	 	    IF nn_ IS NULL THEN nn_:=0; END IF;
		 END;
           ELSE
		 BEGIN
		    SELECT sum(dos)
			INTO nn_
			FROM  saldob
			WHERE acc  =  acc_   AND
			      fdat >= fdat1_ AND
				  fdat <= fdat2_ ;
	 	    IF nn_ IS NULL THEN nn_:=0; END IF;
  		 END;
	   END IF;
   RETURN nn_;
END FDOSQ_S;
/
 show err;
 
PROMPT *** Create  grants  FDOSQ_S ***
grant EXECUTE                                                                on FDOSQ_S         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FDOSQ_S         to START1;
grant EXECUTE                                                                on FDOSQ_S         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fdosq_s.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 