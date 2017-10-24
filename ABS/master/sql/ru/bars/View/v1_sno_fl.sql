

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V1_SNO_FL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V1_SNO_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V1_SNO_FL ("ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SPN", "LIM", "REFP") AS 
  SELECT d.ND, d.NDI, d.SDATE, d.WDATE, d.SOS, d.RNK, d.BRANCH, d.CC_ID, a.KV, a.NLS, a.TIP, a.ACC, -a.OSTC / 100 SPN,
         (SELECT -ostc/100 FROM accounts aa, nd_acc nn  WHERE nn.nd = d.nd AND nn.acc = aa.acc AND aa.tip = 'LIM') LIM,
         (SELECT refp      FROM cc_add                  WHERE nd = d.nd AND refv = a.acc                         ) REFP
   FROM accounts a, cc_deal d, nd_acc n
   WHERE A.ACC = N.ACC   AND A.TIP = 'SPN'    AND N.ND = D.ND   AND D.VIDD IN (11, 12, 13)    AND A.OSTC < 0
   --AND a.ostc =a.ostb
     AND d.branch LIKE  SYS_CONTEXT ('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V1_SNO_FL ***
grant SELECT                                                                 on V1_SNO_FL       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V1_SNO_FL.sql =========*** End *** ====
PROMPT ===================================================================================== 
