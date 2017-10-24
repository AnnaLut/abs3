create or replace view cc_W017 as 
SELECT decode(x.tip
             ,'LIM'
             ,0
             ,'SS '
             ,3
             ,'SN '
             ,8
             ,'SP '
             ,7
             ,'SPN'
             ,9
             ,'SDI'
             ,6
             ,'SPI'
             ,5
             ,'S36'
             ,16
             ,'SNA'
             ,17
             ,'SK0'
             ,18
             ,'SK9'
             ,19
             ,'SG '
             ,20
             ,'ISG'
             ,21
             ,'SNO'
             ,10
             ,'CR9'
             ,30
             ,90) ord
      ,nd
      ,rnk
      ,opn
      ,acc
      ,tip
      ,ob22
      ,nms
      ,kv
      ,ostc
      ,ostb
      ,ostf
      ,dos
      ,kos
      ,dapp
      ,daos
      ,dazs
      ,mdate
      ,isp
      ,decode(ir, 0, NULL, ir) ir
      ,CASE
         WHEN x.ir > 0 THEN
          (SELECT basey
             FROM int_accn
            WHERE id = 0
              AND acc = x.acc)
         ELSE
          to_number(NULL)
       END basey
      ,cck_ui.url_tip(x.sos
                     ,x.dazs
                     ,x.nd
                     ,x.cc_id
                     ,x.sdate
                     ,x.tip
                     ,x.nls
                     ,x.kv
                     ,x.lim
                     ,x.ostc
                     ,x.mfob
                     ,x.nlsb
                     ,x.okpo
                     ,x.nmk) tt
      ,cck_ui.na_nls(x.nls
                    ,to_number(pul.get_mas_ini_val('ACCC'))
                    ,x.tip
                    ,x.prod) nls
  FROM (SELECT d.sos
              ,d.prod
              ,n.nd
              ,a.rnk
              ,1 opn
              ,a.acc
              ,a.tip
              ,a.ob22
              ,a.nls
              ,a.nms
              ,a.kv
              ,acrn.fprocn(a.acc, 0) ir
              ,a.ostc / 100 ostc
              ,a.ostb / 100 ostb
              ,a.ostf / 100 ostf
              ,a.dos / 100 dos
              ,a.kos / 100 kos
              ,a.dapp
              ,a.daos
              ,a.dazs
              ,a.mdate
              ,a.isp
              ,c.acckred nlsb
              ,c.mfokred mfob
              ,u.okpo
              ,u.nmk
              ,d.cc_id
              ,d.sdate
              ,c.s lim
          FROM accounts a, nd_acc n, cc_add c, customer u, cc_deal d
         WHERE d.nd = to_number(pul.get_mas_ini_val('ND'))
           AND d.nd = c.nd
           AND c.adds = 0
           AND c.nd = n.nd
           AND n.acc = a.acc
           AND u.rnk = a.rnk
        UNION ALL
        SELECT 0 sos
              ,d.prod
              ,d.nd
              ,d.rnk
              ,0 opn
              ,to_number(NULL) acc
              ,t.tip
              ,'' ob22
              ,'N/A' nls
              ,t.name
              ,CASE
                 WHEN d.vidd IN (3, 13)
                      OR t.tip IN ('SN8', 'SK0', 'SK9') THEN
                  to_number(NULL)
                 ELSE
                  (SELECT a1.kv
                     FROM accounts a1, nd_acc n1
                    WHERE a1.tip = 'LIM'
                      AND a1.acc = n1.acc
                      AND n1.nd = d.nd)
               END kv
              ,to_number(NULL) ir
              ,to_number(NULL) ostc
              ,to_number(NULL) ostb
              ,to_number(NULL) ostf
              ,to_number(NULL) dos
              ,to_number(NULL) kos
              ,to_date(NULL) dapp
              ,to_date(NULL) daos
              ,to_date(NULL) dazs
              ,d.wdate mdate
              ,to_number(NULL) isp
              ,''
              ,''
              ,u.okpo
              ,u.nmk
              ,d.cc_id
              ,d.sdate
              ,NULL
          FROM (SELECT *
                  FROM cc_deal
                 WHERE sos < 14
                   AND nd = to_number(pul.get_mas_ini_val('ND'))) d
              ,customer u
              ,(SELECT *
                  FROM tips
                 WHERE tip NOT IN ('LIM', 'SD ', 'SL ', 'SLK', 'SLN')) t
              ,vidd_tip v
         WHERE d.vidd = v.vidd
           AND d.rnk = u.rnk
           AND v.tip = t.tip
           AND (d.vidd IN (2, 3, 12, 13) OR NOT EXISTS
                (SELECT 1
                   FROM accounts a2, nd_acc n2
                  WHERE a2.acc = n2.acc
                    AND n2.nd = d.nd
                    AND a2.tip = t.tip))) x;
