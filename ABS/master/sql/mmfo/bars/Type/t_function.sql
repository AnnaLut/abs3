
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_function.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_FUNCTION force as object ( funcname varchar2(250 char), name varchar2(70 char), child_functions t_child_functions );
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_function.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 