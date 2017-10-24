
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq_s.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ_S (acc_ INTEGER, fdat_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
kv_     INTEGER;
BEGIN
     BEGIN
	  SELECT kv INTO kv_  FROM accounts WHERE acc=acc_;
        	EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0;
     END;
     IF kv_=980 THEN
	     BEGIN
	      SELECT a.ostf-a.dos+a.kos
		  INTO nn_
		  FROM  saldoa a
		  WHERE a.acc = acc_ AND
                  (a.acc,a.fdat)=(SELECT acc,MAX (fdat) FROM saldoA
                                WHERE acc=a.acc AND fdat <= fdat_ GROUP BY acc);
         	  IF nn_ IS NULL THEN nn_:=0; END IF;
		 END;
		ELSE
		 BEGIN
		  SELECT a.ostf-a.dos+a.kos
		  INTO nn_
		  FROM  saldob a
		  WHERE a.acc = acc_ AND
                  (a.acc,a.fdat)=(SELECT acc,MAX (fdat) FROM saldoB
                                WHERE acc=a.acc AND fdat <= fdat_ GROUP BY acc);
	 	  IF nn_ IS NULL THEN nn_:=0; END IF;
		 END;
     END IF;
   RETURN nn_;
END FOSTQ_S;
/
 show err;
 
PROMPT *** Create  grants  FOSTQ_S ***
grant EXECUTE                                                                on FOSTQ_S         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTQ_S         to START1;
grant EXECUTE                                                                on FOSTQ_S         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq_s.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 