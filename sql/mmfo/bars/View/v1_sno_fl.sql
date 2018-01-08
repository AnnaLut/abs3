

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V1_SNO_FL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V1_SNO_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V1_SNO_FL ("ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SPN", "LIM", "REFP") AS 
  SELECT d.nd
      ,d.ndi
      ,d.sdate
      ,d.wdate
      ,d.sos
      ,d.rnk
      ,d.branch
      ,d.cc_id
      ,a.kv
      ,a.nls
      ,a.tip
      ,a.acc
      ,-a.ostc / 100 spn
      ,(SELECT -ostc / 100
          FROM accounts aa, nd_acc nn
         WHERE nn.nd = d.nd
           AND nn.acc = aa.acc
           AND aa.tip = 'LIM') lim
      ,(SELECT refp
          FROM cc_add
         WHERE nd = d.nd
           AND refv = a.acc) refp
  FROM accounts a, cc_deal d, nd_acc n
 WHERE a.acc = n.acc
   AND a.tip = 'SPN'
   AND n.nd = d.nd
   AND d.vidd IN (11, 12, 13)
   AND a.ostc < 0
      --AND a.ostc =a.ostb
   AND d.branch LIKE sys_context('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V1_SNO_FL ***
grant SELECT                                                                 on V1_SNO_FL       to BARSREADER_ROLE;
grant SELECT                                                                 on V1_SNO_FL       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V1_SNO_FL       to START1;
grant SELECT                                                                 on V1_SNO_FL       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V1_SNO_FL.sql =========*** End *** ====
PROMPT ===================================================================================== 
