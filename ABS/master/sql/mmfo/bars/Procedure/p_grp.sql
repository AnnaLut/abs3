

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_GRP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_GRP ***

  CREATE OR REPLACE PROCEDURE BARS.P_GRP (p_policygroup in varchar2) is
begin
  bc.set_policy_group(p_policygroup);
end; 
 
/
show err;

PROMPT *** Create  grants  P_GRP ***
grant EXECUTE                                                                on P_GRP           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_GRP.sql =========*** End *** ===
PROMPT ===================================================================================== 
