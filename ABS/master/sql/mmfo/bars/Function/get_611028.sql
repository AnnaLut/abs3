
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_611028.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_611028 (p_ref oper.ref%type) return varchar2
is
--l_branch branch.branch%type;
begin
 --select substr(d_rec, 9, 15) into l_branch from oper where ref=p_ref;
 --return nbs_ob22_bra('6110', '28', l_branch);
 return vkrzn(substr(sys_context('bars_context','user_mfo'),1,5), '6510_002800000');
end;
/
 show err;
 
PROMPT *** Create  grants  GET_611028 ***
grant EXECUTE                                                                on GET_611028      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_611028      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_611028.sql =========*** End ***
 PROMPT ===================================================================================== 
 