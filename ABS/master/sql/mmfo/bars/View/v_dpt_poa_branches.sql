

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_POA_BRANCHES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_POA_BRANCHES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_POA_BRANCHES ("BRANCH", "ORD", "ACTIVE", "KRED", "BOSS", "FIO", "ID") AS 
  SELECT branch,
            ord,
            active,
            kred,
            boss,
            p.fio,
            pb.poa_id
       FROM dpt_poa_branches pb, dpt_poas p
      WHERE     pb.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
            AND pb.poa_id = p.id
   ORDER BY pb.branch, pb.ord;

PROMPT *** Create  grants  V_DPT_POA_BRANCHES ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_POA_BRANCHES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_DPT_POA_BRANCHES to DPT_ADMIN;
grant FLASHBACK,SELECT                                                       on V_DPT_POA_BRANCHES to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_POA_BRANCHES.sql =========*** End
PROMPT ===================================================================================== 
