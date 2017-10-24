
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/gettblusedspace.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETTBLUSEDSPACE ( tablename_ VARCHAR2 )
RETURN NUMBER
IS
    nUsedSpace_ NUMBER;

BEGIN

    BEGIN
        SELECT NUM_ROWS * AVG_ROW_LEN INTO nUsedSpace_
          FROM user_tables
         WHERE table_name = UPPER(tablename_);

    EXCEPTION WHEN NO_DATA_FOUND THEN
        nUsedSpace_ := 0;

    END;

    RETURN nUsedSpace_;

END gettblusedspace;
/
 show err;
 
PROMPT *** Create  grants  GETTBLUSEDSPACE ***
grant EXECUTE                                                                on GETTBLUSEDSPACE to ABS_ADMIN;
grant EXECUTE                                                                on GETTBLUSEDSPACE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETTBLUSEDSPACE to START1;
grant EXECUTE                                                                on GETTBLUSEDSPACE to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/gettblusedspace.sql =========*** En
 PROMPT ===================================================================================== 
 