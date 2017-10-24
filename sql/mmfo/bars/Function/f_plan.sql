
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_plan.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PLAN (KV1 NUMBER,nls1 varchar2, s1 number) rETURN NUMBER IS
nn_ number;
BEGIN
 select ostb into nn_ from accounts where nls=nls1 and kv=kv1;
 if nn_ >=0 then
    return 0;
 else
    return least (s1, -nn_);
 end if;
END f_plan;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_plan.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 