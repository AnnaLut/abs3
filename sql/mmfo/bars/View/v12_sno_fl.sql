

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V12_SNO_FL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V12_SNO_FL ***

  CREATE OR REPLACE FORCE VIEW BARS.V12_SNO_FL ("ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SNO", "LIM") AS 
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
      ,-a.ostc / 100 sno
      ,(SELECT -ostc / 100
          FROM accounts aa, nd_acc nn
         WHERE nn.nd = d.nd
           AND nn.acc = aa.acc
           AND aa.tip = 'LIM') lim
  FROM accounts a, cc_deal d, nd_acc n
 WHERE a.acc = n.acc
   AND a.tip = 'SNO'
   AND n.nd = d.nd
   AND d.vidd IN (11, 12, 13)
   AND (a.ostc <> 0 AND a.ostb = a.ostc AND a.ostf = 0)
   AND d.branch LIKE sys_context('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V12_SNO_FL ***
grant SELECT                                                                 on V12_SNO_FL      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V12_SNO_FL      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V12_SNO_FL.sql =========*** End *** ===
PROMPT ===================================================================================== 
