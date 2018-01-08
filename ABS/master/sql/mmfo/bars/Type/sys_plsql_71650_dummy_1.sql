
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sys_plsql_71650_dummy_1.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SYS_PLSQL_71650_DUMMY_1 as table of number;
/

 show err;
 
PROMPT *** Create  grants  SYS_PLSQL_71650_DUMMY_1 ***
grant EXECUTE                                                                on SYS_PLSQL_71650_DUMMY_1 to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sys_plsql_71650_dummy_1.sql =========**
 PROMPT ===================================================================================== 
 