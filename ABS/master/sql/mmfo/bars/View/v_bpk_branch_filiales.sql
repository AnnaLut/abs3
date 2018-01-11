

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_BRANCH_FILIALES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_BRANCH_FILIALES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_BRANCH_FILIALES ("BRANCH", "BRANCH_NAME", "CODE", "NAME", "CITY", "STREET") AS 
  select b.branch, r.name, d.code, d.name, d.city, d.street
  from branch_parameters b, demand_filiales d, branch r
 where b.tag = 'BPK_BRANCH'
   and b.val = d.code
   and d.mfo = getglobaloption('GLB-MFO')
   and b.branch = r.branch
   and b.branch like sys_context ('bars_context', 'user_branch_mask');

PROMPT *** Create  grants  V_BPK_BRANCH_FILIALES ***
grant SELECT                                                                 on V_BPK_BRANCH_FILIALES to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_BRANCH_FILIALES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_BRANCH_FILIALES to OBPC;
grant SELECT                                                                 on V_BPK_BRANCH_FILIALES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_BRANCH_FILIALES.sql =========*** 
PROMPT ===================================================================================== 
