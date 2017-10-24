
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fostq_gl.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FOSTQ_GL (acc_ INTEGER, fdat_ DATE)
RETURN DECIMAL IS
nn_     DECIMAL;
kv_     INTEGER;
BEGIN
     BEGIN
	  SELECT kv
	  INTO kv_
	  FROM v_gl
	  WHERE acc=acc_;
	 	EXCEPTION WHEN NO_DATA_FOUND THEN RETURN null;
	 END;
 	   IF kv_=980 THEN
	     BEGIN
	      SELECT ost
		  INTO nn_
		  FROM  sal_gl
		  WHERE acc = acc_ AND fdat = fdat_ ;
	 	   IF nn_ IS NULL THEN nn_:=0; END IF;
		 END;
		ELSE
		 BEGIN
		  SELECT ost
		  INTO nn_
		  FROM  salb_gl
		  WHERE acc = acc_ AND fdat = fdat_ ;
	 	   IF nn_ IS NULL THEN nn_:=0; END IF;
		 END;
	   END IF;
   RETURN nn_;
END;
/
 show err;
 
PROMPT *** Create  grants  FOSTQ_GL ***
grant EXECUTE                                                                on FOSTQ_GL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOSTQ_GL        to RPBN001;
grant EXECUTE                                                                on FOSTQ_GL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fostq_gl.sql =========*** End *** =
 PROMPT ===================================================================================== 
 