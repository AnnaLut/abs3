
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sys_plsql_36706_dummy_2.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SYS_PLSQL_36706_DUMMY_2 as table of number;
/

 show err;
 
PROMPT *** Create  grants  SYS_PLSQL_36706_DUMMY_2 ***
grant EXECUTE                                                                on SYS_PLSQL_36706_DUMMY_2 to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sys_plsql_36706_dummy_2.sql =========**
 PROMPT ===================================================================================== 
 