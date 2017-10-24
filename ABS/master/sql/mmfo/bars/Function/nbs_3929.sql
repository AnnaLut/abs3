
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/nbs_3929.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.NBS_3929 RETURN varchar2 IS

    fRes_    SMALLINT;
    VAL_     varchar2(50);

BEGIN
    fRes_ := 0;
    SELECT COUNT(*) INTO fRes_
    FROM params
    WHERE  upper(par) = 'NBS_3929';
    IF fRes_ > 0 THEN
	   SELECT VAL INTO VAL_ FROM PARAMS
	   WHERE UPPER(PAR)='NBS_3929';
    ELSE val_:='0001';
    END IF;

    RETURN val_;

END NBS_3929;
 
/
 show err;
 
PROMPT *** Create  grants  NBS_3929 ***
grant EXECUTE                                                                on NBS_3929        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on NBS_3929        to RPBN001;
grant EXECUTE                                                                on NBS_3929        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/nbs_3929.sql =========*** End *** =
 PROMPT ===================================================================================== 
 