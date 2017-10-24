

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_REPO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_REPO ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_REPO ("ID", "ND", "REF", "REF_REPO", "SOS", "DAT_UG", "DAT_OPL", "DAT_ROZ", "ACC", "NLS", "DAOS", "DAZS", "SUMB", "N", "D", "P", "R", "S", "Z", "STR_REF", "OP", "SN") AS 
  select  
id, nd, ar.ref, ref_repo, o.sos, dat_ug, dat_opl, dat_roz, 
ar.acc,   a.nls , a.daos, a.dazs,
sumb, N, D, P, R, ar.S, Z, str_ref, op, SN
from cp_arch ar, oper o, accounts a 
where ref_repo is not null --and op<>2
      and o.ref=ar.ref and a.acc(+)=ar.acc;

PROMPT *** Create  grants  CP_V_REPO ***
grant SELECT                                                                 on CP_V_REPO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_V_REPO       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_REPO.sql =========*** End *** ====
PROMPT ===================================================================================== 
