
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_finmon_table.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_FINMON_TABLE as table of varchar2(350)
/

 show err;
 
PROMPT *** Create  grants  T_FINMON_TABLE ***
grant EXECUTE                                                                on T_FINMON_TABLE  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_finmon_table.sql =========*** End ***
 PROMPT ===================================================================================== 
 