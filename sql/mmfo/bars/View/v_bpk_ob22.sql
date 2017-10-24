

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_OB22.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_OB22 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_OB22 ("TYPE", "CARD_TYPE", "ACC_TYPE", "CARD_NAME", "NBS", "OB22", "OB22_NAME", "TIP", "CUSTTYPE") AS 
  select d.type, d.card_type, d.acc_type, d.name,
       n.nbs, n.ob22, s.txt, n.tip, n.custtype
  from demand_acc_type d, bpk_nbs n, sb_ob22 s
 where d.tip  = n.tip
   and n.nbs  = s.r020
   and n.ob22 = s.ob22;

PROMPT *** Create  grants  V_BPK_OB22 ***
grant SELECT                                                                 on V_BPK_OB22      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_OB22      to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_OB22.sql =========*** End *** ===
PROMPT ===================================================================================== 
