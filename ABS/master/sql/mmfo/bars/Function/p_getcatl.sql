
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/p_getcatl.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.P_GETCATL ( tt_ CHAR, l_ INT ) RETURN INT IS

--
-- @(#) p_getcatlo.sql 3.1.1.1 98/09/21
-- Get Checker Id for transaction _tt on the level _level
-- ORACLE instance
-- ( DEN )
--

idchk_    INT;
priority_ INT;
level_    INT;
lc_ INT;
ID_ INT;

CURSOR CLst IS
    SELECT idchk, priority FROM chklist_tts
    WHERE tt=tt_ ORDER BY priority;

BEGIN

lc_    := 1;
ID_    := NULL;
level_ := l_;

IF level_ IS NULL THEN
    level_ := 1;
END IF;

OPEN CLst;
LOOP
    FETCH CLst INTO idchk_, priority_;
    EXIT WHEN CLst%NOTFOUND;
    IF lc_ = level_ THEN
        ID_ := idchk_;
        RETURN ID_;
    END IF;
    lc_ := lc_ + 1;
END LOOP;

RETURN ID_;

END;

 
/
 show err;
 
PROMPT *** Create  grants  P_GETCATL ***
grant EXECUTE                                                                on P_GETCATL       to ABS_ADMIN;
grant EXECUTE                                                                on P_GETCATL       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_GETCATL       to RPBN001;
grant EXECUTE                                                                on P_GETCATL       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/p_getcatl.sql =========*** End *** 
 PROMPT ===================================================================================== 
 