
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/sys_plsql_36706_45_2.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.SYS_PLSQL_36706_45_2 as table of VARCHAR2(8);
/

 show err;
 
PROMPT *** Create  grants  SYS_PLSQL_36706_45_2 ***
grant EXECUTE                                                                on SYS_PLSQL_36706_45_2 to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/sys_plsql_36706_45_2.sql =========*** E
 PROMPT ===================================================================================== 
 