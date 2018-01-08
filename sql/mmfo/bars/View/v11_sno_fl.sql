

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V11_SNO_FL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V11_SNO_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V11_SNO_FL ("REFP", "VDAT", "ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SNO", "LIM", "SNOB", "OTM1", "OTM2") AS 
  SELECT c.refp
      ,o.vdat
      ,d.nd
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
      ,-a.ostc / 100 sno
      ,(SELECT -ostc / 100
          FROM accounts aa, nd_acc nn
         WHERE nn.nd = d.nd
           AND nn.acc = aa.acc
           AND aa.tip = 'LIM') lim
      ,(a.ostf + a.ostc) / 100 snob
      ,0 otm1
      ,0 otm2
  FROM accounts a, cc_deal d, nd_acc n, cc_add c, oper o
 WHERE d.nd = c.nd
   AND c.adds = 0
   AND c.refp = o.ref
   AND o.ref > 0
   AND a.acc = n.acc
   AND a.tip = 'SNO'
   AND n.nd = d.nd
   AND d.vidd IN (11, 12, 13)
   AND (a.ostc <> 0 OR a.ostf <> 0)
   AND d.branch LIKE sys_context('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V11_SNO_FL ***
grant SELECT                                                                 on V11_SNO_FL      to BARSREADER_ROLE;
grant SELECT                                                                 on V11_SNO_FL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V11_SNO_FL      to START1;
grant SELECT                                                                 on V11_SNO_FL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V11_SNO_FL.sql =========*** End *** ===
PROMPT ===================================================================================== 
