
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_tabid.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_TABID (TABNAME_ VARCHAR2) RETURN NUMBER IS
  TABID_ NUMBER;
  BEGIN
    BEGIN
      SELECT TABID INTO TABID_
      FROM META_TABLES WHERE TABNAME=TABNAME_;
      EXCEPTION WHEN NO_DATA_FOUND THEN TABID_:=NULL;
    END;
   RETURN TABID_;
 END;
 
/
 show err;
 
PROMPT *** Create  grants  GET_TABID ***
grant EXECUTE                                                                on GET_TABID       to ABS_ADMIN;
grant EXECUTE                                                                on GET_TABID       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_TABID       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_tabid.sql =========*** End *** 
 PROMPT ===================================================================================== 
 