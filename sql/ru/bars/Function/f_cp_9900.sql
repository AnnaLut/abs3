
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_cp_9900.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CP_9900 return varchar2
is
 l_nls varchar2(15);
begin
 l_nls := '9900107'; -- заменить на спецпараметр
 return l_nls;
end;
/
 show err;
 
PROMPT *** Create  grants  F_CP_9900 ***
grant DEBUG,EXECUTE                                                          on F_CP_9900       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_cp_9900.sql =========*** End *** 
 PROMPT ===================================================================================== 
 