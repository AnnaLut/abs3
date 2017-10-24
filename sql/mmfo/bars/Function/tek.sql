
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/tek.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TEK (KV_ NUMBER, s_ number) rETURN NUMBER
IS
begin
 RETURN gl.p_icurval(kv_,s_,bankdate);
END tek;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/tek.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 