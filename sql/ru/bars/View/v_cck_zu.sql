  CREATE OR REPLACE VIEW  V_CCK_ZU AS
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
                    FROM nd_txt
                   WHERE nd = d.nd
                     AND tag = 'PR_TR') pr_tr
            FROM cc_deal d, customer c, accounts a8, nd_acc n
           WHERE n.nd = d.nd
             AND c.rnk = d.rnk
             AND c.rnk = a8.rnk
             AND n.acc = a8.acc
             AND a8.tip = 'LIM'
             AND d.vidd IN (1, 2, 3)
             AND d.sos > 13) x;
