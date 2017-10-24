
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/isnbubank.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ISNBUBANK RETURN SMALLINT IS

    fRes_    SMALLINT;
	VAL_     varchar2(50);

BEGIN
    fRes_ := 0;
    SELECT COUNT(*) INTO fRes_
    FROM params
    WHERE  upper(par) = 'NBUBANK';
    IF fRes_ > 0 THEN
	   SELECT VAL INTO VAL_ FROM PARAMS
	   WHERE UPPER(PAR)='NBUBANK';
       IF VAL_='1' THEN
        fRes_ := 1;
       ELSE
	    fRes_ :=0 ;
       END IF;
     END IF;

    RETURN fRes_;

END IsNBUBank;

 
/
 show err;
 
PROMPT *** Create  grants  ISNBUBANK ***
grant EXECUTE                                                                on ISNBUBANK       to ABS_ADMIN;
grant EXECUTE                                                                on ISNBUBANK       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ISNBUBANK       to RPBN001;
grant EXECUTE                                                                on ISNBUBANK       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/isnbubank.sql =========*** End *** 
 PROMPT ===================================================================================== 
 