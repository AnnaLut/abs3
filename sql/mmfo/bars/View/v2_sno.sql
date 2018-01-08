

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V2_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V2_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.V2_SNO ("VIDD", "REFP", "VDAT", "ND", "NDI", "SDATE", "WDATE", "SOS", "RNK", "BRANCH", "CC_ID", "KV", "NLS", "TIP", "ACC", "SNO", "SNO_PLAN", "SNO_GPP", "SNOB", "LIM") AS 
  SELECT d.vidd
      ,c.ref refp
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
      ,a.ostc / 100 sno
      ,a.ostb / 100 sno_plan
      ,a.ostf / 100 sno_gpp
      ,(a.ostf + a.ostc) / 100 snob
      ,(SELECT ostc / 100
          FROM accounts aa, nd_acc nn
         WHERE nn.nd = d.nd
           AND nn.acc = aa.acc
           AND aa.tip = 'LIM') lim
  FROM accounts a, cc_deal d, nd_acc n, sno_ref c, oper o
 WHERE c.acc = a.acc
   AND c.ref = o.ref
   AND a.acc = n.acc
   AND a.tip = 'SNO'
   AND n.nd = d.nd
   AND d.vidd IN (1, 2, 3, 11, 12, 13)
   AND (a.ostc <> 0 OR a.ostf <> 0)
   AND d.branch LIKE sys_context('bars_context', 'user_branch') || '%';

PROMPT *** Create  grants  V2_SNO ***
grant SELECT                                                                 on V2_SNO          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V2_SNO          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V2_SNO          to START1;
grant SELECT                                                                 on V2_SNO          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V2_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
