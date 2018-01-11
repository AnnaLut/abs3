

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_RU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_RU ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_RU ("ND", "NDI", "NDG", "VIDD", "PROD", "ISP", "CC_ID", "RNK", "KV", "S", "GPK", "DSDATE", "DWDATE", "PR", "OSTC", "SOS", "NAMK", "ACC8", "DAZS", "BRANCH", "CUSTTYPE", "SDOG", "TR", "VIDD_NAME", "SOS_NAME", "DAYSN", "FREQ", "FREQP", "OPL_DATE", "OPL_DAY", "ND0", "I_CR9") AS 
  SELECT x.nd
      ,x.ndi
      ,x.ndg
      ,x.vidd
      ,x.prod
      ,x.isp
      ,x.cc_id
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
      ,x.sdog
      ,CASE
         WHEN vidd IN (2, 3)
              AND pr_tr = '1' THEN
          1
         ELSE
          0
       END tr
      ,x.vidd_name
      ,x.sos_name
      ,x.daysn
      ,x.freq
      ,x.freqp
      ,x.opl_date
      ,x.opl_day
      ,(SELECT COUNT(*)
          FROM cc_deal
         WHERE ndg = x.nd
           AND nd <> ndg) nd0
      ,x.i_cr9
  FROM (SELECT d.nd
              ,d.ndi
              ,d.ndg
              ,d.vidd
              ,d.prod
              ,d.user_id isp
              ,d.cc_id
              ,d.rnk
              ,a8.kv
              ,d.limit s
              ,a8.vid gpk
              ,d.sdate dsdate
              ,d.wdate dwdate
              ,acrn.fprocn(a8.acc, 0, gl.bd) pr
              ,-a8.ostc / 100 ostc
              ,d.sos
              ,c.nmk namk
              ,a8.acc acc8
              ,a8.dazs
              ,d.branch
              ,decode(d.vidd, 1, 2, 2, 2, 3, 2, 3) custtype
              ,d.sdog
              ,vid.name vidd_name
              ,sos.name sos_name
              ,ia.apl_dat opl_date
              ,ia.s opl_day
              ,(SELECT txt
                  FROM bars.nd_txt
                 WHERE nd = d.nd
                   AND tag = 'PR_TR') pr_tr
              ,(SELECT txt
                  FROM bars.nd_txt
                 WHERE nd = d.nd
                   AND tag = 'DAYSN') daysn
              ,(SELECT fr.name
                  FROM bars.nd_txt t, bars.freq fr
                 WHERE t.txt = fr.freq
                   AND nd = d.nd
                   AND t.tag = 'FREQP') freqp
              ,(SELECT fr.name
                  FROM bars.nd_txt t, bars.freq fr
                 WHERE t.txt = fr.freq
                   AND nd = d.nd
                   AND t.tag = 'FREQ') freq
              ,(SELECT decode(t.txt
                             ,0
                             ,'Відновлювана'
                             ,1
                             ,'Невідновлювана')
                  FROM bars.nd_txt t
                 WHERE nd = d.nd
                   AND t.tag = 'I_CR9') i_cr9
          FROM (SELECT *
                  FROM bars.cc_deal
                 WHERE vidd IN (1, 2, 3)
                   AND sos > 0
                   AND sos < 14
                   AND nd = nvl(ndg, nd)) d
              ,bars.customer c
              ,bars.accounts a8
              ,bars.nd_acc n
              ,bars.cc_vidd vid
              ,bars.cc_sos sos
              ,bars.int_accn ia
         WHERE n.nd = d.nd
           AND d.vidd = vid.vidd
           AND d.sos = sos.sos
           AND c.rnk = d.rnk
           AND c.rnk = a8.rnk
           AND ia.acc = a8.acc
           AND ia.id = 0
           AND n.acc = a8.acc
           AND a8.tip = 'LIM') x;

PROMPT *** Create  grants  V_CCK_RU ***
grant SELECT                                                                 on V_CCK_RU        to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_RU        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_RU        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_RU.sql =========*** End *** =====
PROMPT ===================================================================================== 
