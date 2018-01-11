

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_DEAL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_DEAL ("ND", "ACC") AS 
  select nd, acc_pk from bpk_acc
union all
select nd, acc_pk from w4_acc;

PROMPT *** Create  grants  V_BPK_DEAL ***
grant SELECT                                                                 on V_BPK_DEAL      to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_DEAL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_DEAL      to OBPC;
grant SELECT                                                                 on V_BPK_DEAL      to OW;
grant SELECT                                                                 on V_BPK_DEAL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_DEAL.sql =========*** End *** ===
PROMPT ===================================================================================== 
