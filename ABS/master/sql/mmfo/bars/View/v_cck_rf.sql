

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_RF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_RF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_RF ("ISP", "ND", "CC_ID", "VIDD", "RNK", "KV", "S", "GPK", "DSDATE", "DWDATE", "PR", "OSTC", "SOS", "NAMK", "ACC8", "DAZS", "BRANCH", "CUSTTYPE", "PROD", "SDOG", "NDI", "VIDD_NAME", "SOS_NAME", "NLS", "TR", "OPL_DAY", "BASEM","BASEY_NAME"
       ,"ANNUITET") AS  
  SELECT x.isp
      ,x.nd
      ,x.cc_id
      ,x.vidd
      ,x.rnk
      ,x.kv
      ,x.s
      ,x.gpk
      ,x.dsdate
      ,x.dwdate
      ,x.pr
      ,x.ostc
      ,x.sos
      ,x.namk
      ,x.acc8
      ,x.dazs
      ,x.branch
      ,x.custtype
      ,x.prod
      ,x.sdog
      ,x.ndi
      ,x.vidd_name
      ,x.sos_name
      ,x.nls
      ,CASE
         WHEN vidd IN (2, 3)
              AND pr_tr = '1' THEN
          1
         ELSE
          0
       END tr
       ,x.opl_day
       ,x.basem
	   ,x.basey_name
       ,x.annuitet
  FROM (SELECT d.user_id isp
              ,d.nd
              ,d.cc_id
              ,d.vidd
              ,d.rnk
              ,a8.kv
              ,d.limit s
              ,cv.name vidd_name
              ,cs.name sos_name
              ,a8.vid gpk
              ,d.sdate dsdate
              ,d.wdate dwdate
              ,acrn.fprocn(a8.acc, 0, gl.bd) pr
              ,-a8.ostc / 100 ostc
              ,d.sos
              ,c.nmk namk
              ,a8.acc acc8
              ,a8.dazs
              ,a8.nls
              ,d.branch
              ,decode(d.vidd, 1, 2, 2, 2, 3, 2, 3) custtype
              ,d.prod
              ,d.sdog
              ,d.ndi
              ,(SELECT txt
                  FROM nd_txt
                 WHERE nd = d.nd
                   AND tag = 'PR_TR') pr_tr
               ,ia.s opl_day
                ,ia.basem
			   ,(select name from basey b where b.basey = ia.basem) basey_name
                ,CASE WHEN ia.basey = 2 AND ia.basem = 1 AND ia.id = 0 THEN 'Старий ануїтет'
                      WHEN ia.basey = 2 AND ia.basem = 0 AND ia.id = 0 THEN 'Новий ануїтет'
                      ELSE 'Класичний'
                 END  annuitet
          FROM cc_deal d, customer c, accounts a8, nd_acc n, cc_sos cs,cc_vidd cv,INT_accn ia
         WHERE n.nd = d.nd
           AND c.rnk = d.rnk
           AND c.rnk = a8.rnk
           and ia.acc=a8.acc
           and ia.id=0
           AND n.acc = a8.acc
           and cs.sos=d.sos
           and cv.vidd=d.vidd
           AND a8.tip = 'LIM'
           AND d.vidd IN (11, 12, 13)
           AND d.sos > 0
           AND d.sos < 14) x where x.branch like  SYS_CONTEXT ('bars_context', 'user_branch_mask')
;

PROMPT *** Create  grants  V_CCK_RF ***
grant SELECT                                                                 on V_CCK_RF        to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_RF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_RF        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_RF.sql =========*** End *** =====
PROMPT ===================================================================================== 
