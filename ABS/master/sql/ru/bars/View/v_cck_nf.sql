CREATE OR REPLACE VIEW V_CCK_NF AS
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
      ,x.vidd_name
      ,x.sos_name
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
     ,/*to_char(*/(Select min(cu.chgdate ) from cc_deal_update cu where cu.CHGACTION='I' and cu.nd=x.nd)/*,'YYYY-MM-DD HH:MM:SS')*/ chgdate
  FROM (SELECT d.user_id isp
              ,d.nd
              ,d.cc_id
              ,d.vidd
              ,cv.name vidd_name
              ,cs.name sos_name
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
                  FROM nd_txt
                 WHERE nd = d.nd
                   AND tag = 'PR_TR') pr_tr
          FROM cc_deal d, customer c, accounts a8, nd_acc n, cc_sos cs,cc_vidd cv
         WHERE n.nd = d.nd
           AND c.rnk = d.rnk
           AND c.rnk = a8.rnk
           AND n.acc = a8.acc
           AND a8.tip = 'LIM'
           and cs.sos=d.sos
           and cv.vidd=d.vidd
           AND NOT EXISTS (SELECT 1
                  FROM nd_txt
                 WHERE substr(txt, 1, 1) = '2'
                   AND tag = 'CCSRC'
                   AND nd = d.nd)
           AND d.vidd IN (11, 12, 13)
           AND d.sos = 0) x where x.branch like  SYS_CONTEXT ('bars_context', 'user_branch_mask');
grant select on v_cck_nf to bars_access_defrole;