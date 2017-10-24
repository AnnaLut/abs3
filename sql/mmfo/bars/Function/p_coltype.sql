
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/p_coltype.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.P_COLTYPE ( ColType_ VARCHAR2 ) RETURN INT
IS

--
-- Convert code of column type in system tables into
-- character code for metadata in ABS BARS98 project
-- (DEN)
-- @(#) p_coltype.sql 3.1.1.3 98/09/30
--

retCode_ INT;

BEGIN

retCode_ := 67;

--
-- Numeric
--
IF ColType_ = 'NUMBER' THEN
   retCode_ := 78;
END IF;

--
-- Date
--
IF ColType_ = 'DATE' THEN
   retCode_ := 68;
END IF;

RETURN retCode_;

END;

 
/
 show err;
 
PROMPT *** Create  grants  P_COLTYPE ***
grant EXECUTE                                                                on P_COLTYPE       to ABS_ADMIN;
grant EXECUTE                                                                on P_COLTYPE       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_COLTYPE       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/p_coltype.sql =========*** End *** 
 PROMPT ===================================================================================== 
 