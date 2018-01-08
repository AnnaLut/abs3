
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rkapital.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RKAPITAL (dat_ DATE,
	   	  		  		   			 kodf_ VARCHAR2 DEFAULT NULL,
									 userid_  NUMBER DEFAULT NULL,
									 type_  NUMBER DEFAULT 3  -- =1 - PK1
									 -- =2 - PK2, =3 - РК
									 ) RETURN NUMBER IS
---------------------------------------------------------------------------
--- Функція розрахунку регулятивного капіталу  ---
--- з врахуванням зміни версій	   	                    ---
---------------------------------------------------------------------------
----- 			  Версія від 02.04.2007	   				    ---
---------------------------------------------------------------------------
   datz1_ 	 DATE := TO_DATE('01052005','ddmmyyyy');
   datz2_ 	 DATE := TO_DATE('01042007','ddmmyyyy');
   sum_k	 NUMBER;
BEGIN
   IF dat_ < datz1_ THEN
   	  sum_k := Rkapital_V1(dat_, kodf_, userid_);
   ELSIF dat_ < datz2_ THEN
   	  sum_k := Rkapital_V2(dat_, kodf_, userid_, type_);
   ELSE
   	  sum_k := Rkapital_V3(dat_, kodf_, userid_, type_);
   END IF;

   RETURN sum_k;
END Rkapital;
 
/
 show err;
 
PROMPT *** Create  grants  RKAPITAL ***
grant EXECUTE                                                                on RKAPITAL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rkapital.sql =========*** End *** =
 PROMPT ===================================================================================== 
 