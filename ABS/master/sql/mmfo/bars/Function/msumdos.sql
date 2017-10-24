
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/msumdos.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MSUMDOS (acc_ number, dat_ DATE)
return NUMBER IS
	summ_ NUMBER;
	dat1_ DATE;
	dat2_ DATE;
BEGIN
	dat1_ := TRUNC(TRUNC(bankdate,'MM') - 1, 'MM');
	dat2_ := TRUNC(bankdate,'MM') - 1;

	BEGIN
        SELECT sum(s.dos*krs840(a.kv,s.fdat)) INTO summ_
		FROM saldoa s, accounts a
		WHERE s.acc=a.acc AND s.acc=acc_ AND
		s.fdat BETWEEN dat1_ AND dat2_;

   	    EXCEPTION WHEN NO_DATA_FOUND THEN
	    	summ_ := 0;
	END;

	RETURN summ_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/msumdos.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 