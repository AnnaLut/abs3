
 
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
----- 			  Версія від 25.05.2017	   				    ---
---------------------------------------------------------------------------
   sum_k	 NUMBER;
   fmt_       VARCHAR2(30):='999G999G999G990D99';

   PROCEDURE p_ins(p_kod_ VARCHAR2, p_val_ NUMBER) IS
        pragma     AUTONOMOUS_TRANSACTION;
   BEGIN
       IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
           INSERT INTO OTCN_LOG (kodf, userid, txt)
           VALUES(kodf_,userid_,p_kod_||TO_CHAR(p_val_/100, fmt_));
           commit;
       END IF;
   END;
BEGIN
   p_ins('Дата для регулятивного капіталу: '||TO_CHAR(dat_,'dd.mm.yyyy'), NULL);

   SELECT nvl(a.sumrk, 0)
   into sum_k
   FROM REGCAPITAL a 
   WHERE a.fdat = (select max(fdat) 
                   from REGCAPITAL 
                   where fdat <= Dat_ and
                         nvl(a.sumrk, 0) <> 0);

   p_ins('Регулятивний капітал (із REGCAPITAL): ', sum_k);

   RETURN sum_k;
END Rkapital;
/
 show err;
 
PROMPT *** Create  grants  RKAPITAL ***
grant EXECUTE                                                                on RKAPITAL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rkapital.sql =========*** End *** =
 PROMPT ===================================================================================== 
 