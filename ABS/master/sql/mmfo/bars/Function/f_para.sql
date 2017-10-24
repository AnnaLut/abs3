
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_para.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PARA ( p_ida varchar2, p_idb varchar2) return varchar2
is
begin
  return least(substr('0000000000'||p_ida,-10), substr('0000000000'||p_idb,-10))||greatest(substr('0000000000'||p_ida,-10), substr('0000000000'||p_idb,-10));
end;
/
 show err;
 
PROMPT *** Create  grants  F_PARA ***
grant EXECUTE                                                                on F_PARA          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_PARA          to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_para.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 