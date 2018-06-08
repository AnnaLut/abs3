CREATE OR REPLACE VIEW V_CCK_NU AS
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
      ,CASE
         WHEN vidd IN (2, 3)
              AND pr_tr = '1' THEN
          1
         ELSE
          0
       END tr
      ,x.vidd_name
      ,x.sos_name
      ,x.DAYSN
      ,x.FREQ
      ,x.FREQP
      ,x.opl_date
      ,x.opl_day
      ,x.I_CR9
  FROM (SELECT d.user_id isp
              ,d.nd
              ,d.cc_id
              ,d.vidd
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
              ,d.prod
              ,d.sdog
              ,d.ndi
              ,(SELECT txt
                  FROM bars.nd_txt
                 WHERE nd = d.nd
                   AND tag = 'PR_TR') pr_tr
              ,vid.name vidd_name
              ,sos.name sos_name
              ,(SELECT txt
                  FROM bars.nd_txt t
                 WHERE nd = d.nd
                   AND t.tag = 'DAYSN') daysn
               ,(SELECT fr.name
                  FROM bars.nd_txt t ,bars.FREQ FR
                 WHERE t.txt=fr.freq
                 and nd = d.nd
                   AND t.tag = 'FREQ') FREQ
               ,(SELECT fr.name
                  FROM bars.nd_txt t ,bars.FREQ FR
                 WHERE t.txt=fr.freq
                 and nd = d.nd
                   AND t.tag = 'FREQP') FREQP
                ,(SELECT decode(t.txt,0,'Відновлювана',1,'Невідновлювана')
                  FROM bars.nd_txt t
                 WHERE  nd = d.nd
                   AND t.tag = 'I_CR9') I_CR9
                 ,ia.apl_dat opl_date
                 ,ia.s opl_day
          FROM bars.cc_deal  d
              ,bars.customer c
              ,bars.accounts a8
              ,bars.nd_acc   n
              ,bars.cc_vidd  vid
              ,bars.cc_sos   sos
              ,bars.INT_accn ia
         WHERE n.nd = d.nd
           AND c.rnk = d.rnk
           AND c.rnk = a8.rnk
           AND n.acc = a8.acc
           AND d.vidd = vid.vidd
           AND d.sos = sos.sos
           AND a8.tip = 'LIM'
           and ia.acc= a8.acc
           and ia.id=0
           AND NOT EXISTS (SELECT 1
                  FROM bars.nd_txt
                 WHERE substr(txt, 1, 1) = '2'
                   AND tag = 'CCSRC'
                   AND nd = d.nd)
           AND d.vidd IN (1, 2, 3)
           AND d.sos = 0
		   and d.nd = nvl(d.ndg,d.nd) --COBUPRVNIX-148 
           ) x;
