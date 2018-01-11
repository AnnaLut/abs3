

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V1_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V1_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.V1_SNO ("VIDD", "ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SNO", "SNOB", "LIM", "MDATE") AS 
  SELECT d.vidd
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
      ,-a.ostb / 100 snob
      ,(SELECT -ostc / 100
          FROM accounts aa, nd_acc nn
         WHERE nn.nd = d.nd
           AND nn.acc = aa.acc
           AND aa.tip = 'LIM') lim
      ,a.mdate
  FROM accounts a, cc_deal d, nd_acc n
 WHERE a.acc = n.acc
   AND a.tip = 'SNO'
   AND n.nd = d.nd
   AND d.vidd IN (1, 2, 3, 11, 12, 13)
   AND d.wdate > gl.bd
   AND (a.ostc < 0 AND a.ostf = 0)
   AND d.branch LIKE sys_context('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V1_SNO ***
grant SELECT                                                                 on V1_SNO          to BARSREADER_ROLE;
grant SELECT                                                                 on V1_SNO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V1_SNO          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V1_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
