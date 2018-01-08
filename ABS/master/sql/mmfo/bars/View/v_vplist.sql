

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_VPLIST.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_VPLIST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_VPLIST ("KV", "BRANCH", "NMS3800", "ACC3800", "NLS3800", "OB3800", "DAZS_3800", "ACC3801", "NLS3801", "OB3801", "DAZS_3801", "ACC6204", "NLS6204", "OB6204", "DAZS_6204", "ACC_RRR", "NLS_RRR", "OB_RRR", "DAZS_RRR", "ACC_RRS", "NLS_RRS", "OB_RRS", "DAZS_RRS", "ACC_RRD", "COMM") AS 
  select a.KV, a.BRANCH, a.nms NMS3800,  v.ACC3800,  a.nls NLS3800,  a.ob22 OB3800,  a.dazs dazs_3800,
                                       v.ACC3801,  b.nls NLS3801,  b.ob22 OB3801,  b.dazs dazs_3801,
                                       v.ACC6204,  c.nls NLS6204,  c.ob22 OB6204,  c.dazs dazs_6204,
                                       v.ACC_RRR,  d.nls NLS_RRR,  d.ob22 OB_RRR,  d.dazs dazs_rrr ,
                                       v.ACC_RRS,  e.nls NLS_RRS,  e.ob22 OB_RRS,  e.dazs dazs_rrs ,  v.ACC_RRD,  v.COMM
FROM accounts a,       accounts b,    accounts c,     accounts d,     accounts e,   vp_list v
WHERE v.acc3800 = a.acc     AND v.acc3801 = b.acc  AND v.acc6204 = c.acc(+)  AND v.acc_rrr = d.acc(+)  AND v.acc_rrs = e.acc(+) ;

PROMPT *** Create  grants  V_VPLIST ***
grant SELECT                                                                 on V_VPLIST        to ABS_ADMIN;
grant SELECT                                                                 on V_VPLIST        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_VPLIST        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_VPLIST        to SALGL;
grant SELECT                                                                 on V_VPLIST        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_VPLIST        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_VPLIST.sql =========*** End *** =====
PROMPT ===================================================================================== 
