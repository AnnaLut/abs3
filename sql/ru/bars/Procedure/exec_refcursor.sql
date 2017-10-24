

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/EXEC_REFCURSOR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EXEC_REFCURSOR ***

  CREATE OR REPLACE PROCEDURE BARS.EXEC_REFCURSOR (
   sql_str            VARCHAR2,
   param			  VARCHAR2,
   p_cursor   OUT   sys_refcursor
)
IS
BEGIN
   if param is not null
    then
	 OPEN p_cursor FOR sql_str using param;
	else
     OPEN p_cursor FOR sql_str;
   end if;
END exec_refcursor;
/
show err;

PROMPT *** Create  grants  EXEC_REFCURSOR ***
grant EXECUTE                                                                on EXEC_REFCURSOR  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_ALL_RIGHTS;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_CBIREP;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_CREDIT;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_CUSTLIST;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_CUSTREG;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_DEPOSIT_U;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_DOC_INPUT;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_KP;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_METATAB;
grant EXECUTE                                                                on EXEC_REFCURSOR  to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/EXEC_REFCURSOR.sql =========*** En
PROMPT ===================================================================================== 
