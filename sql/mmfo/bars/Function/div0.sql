
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/div0.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DIV0 (p1 number, p2 number)  RETURN NUMBER is begin  if nvl(p2,0) = 0 then  return (p2); end if;  return (p1/p2);end div0;
/
 show err;
 
PROMPT *** Create  grants  DIV0 ***
grant EXECUTE                                                                on DIV0            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DIV0            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/div0.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 