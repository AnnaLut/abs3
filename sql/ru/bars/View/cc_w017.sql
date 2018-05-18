prompt ##############################################
prompt 6. Çì³íè âþõ ïî ÊÏ ÞÎ.
prompt ##############################################

--------------------------------------------------------

-- cc_W017 ÐÀÕ + Îïåðàö³¿  ---------------------------------
CREATE OR REPLACE FORCE VIEW BARS.CC_W017 AS 
   SELECT DECODE (x.tip,'LIM',0,'SS ',3,'SN ',8,'SP ',7,'SPN',9,'SDI',6,'SPI',5,'S36',16,'SNA',17,'SK0',18,'SK9',19,'SG ',20,'ISG',21,'SNO', 10,'CR9', 30,90) ORD,
          ND, rnk, OPN, ACC, TIP, OB22, NMS, KV, OSTC, OSTB, OSTF, DOS, KOS, dapp, daos, dazs, mdate, isp, DECODE (IR,0,NULL,IR)    IR,
          CASE WHEN x.IR > 0 THEN  (SELECT basey FROM int_accn  WHERE id = 0 AND acc = x.acc)  ELSE  TO_NUMBER (NULL)  END       BASEY,
          cck_ui.URL_TIP (x.SOS, x.DAZS, x.nd, x.cc_id, x.sdate, x.tip, x.nls, x.KV, x.Lim, x.ostc, x.mfob, x.nlsB, x.okpo, x.nmk)  TT,
          cck_ui.NA_NLS  (x.NLS, TO_NUMBER(pul.Get('ACCC') ), x.TIP, x.PROD)   NLS
   FROM (SELECT d.sos, d.prod, n.ND, a.rnk, 1 OPN, a.ACC, a.TIP, a.OB22, a.NLS, a.NMS, a.KV, acrN.fprocN (a.acc, 0) IR, a.ostc / 100 OSTC,
                a.ostb / 100 OSTB, a.ostf / 100 OSTF, a.dos / 100 DOS, a.kos / 100 KOS, a.dapp, a.daos, a.dazs, a.mdate, a.isp,
                c.ACCKRED nlsb, c.MFOKRED mfob, u.okpo, u.nmk, d.cc_id, d.sdate, c.s lim
          FROM accounts a, nd_acc n, cc_add c, customer u,  (select * from cc_deal where nd = TO_NUMBER (pul.Get('ND')) ) d
          WHERE d.nd = c.nd   AND c.adds = 0  AND c.nd = n.nd    AND n.acc = a.acc   AND u.rnk = a.rnk
----and NOT ( d.nd = d.NDG and t.tip in ('SS ', 'SN ', 'SNO', 'SNA', 'SP ', 'SPN', 'SDI', 'SPI' ) )  
          UNION ALL
          SELECT 0 sos, d.prod, d.ND, d.RNK, 0 OPN, TO_NUMBER (NULL) ACC, t.TIP, '' OB22, 'N/A' NLS, t.name, 
                CASE WHEN d.VIDD IN (3,13) OR t.tip IN ('SN8','SK0','SK9') THEN TO_NUMBER(NULL) 
                     ELSE  (SELECT a1.KV FROM accounts a1, nd_acc n1 WHERE  a1.tip = 'LIM' AND a1.acc = n1.acc  AND n1.nd = d.nd) END   KV,
                TO_NUMBER (NULL) IR, TO_NUMBER (NULL) OSTC, TO_NUMBER (NULL) OSTB, TO_NUMBER (NULL) OSTF, TO_NUMBER (NULL) DOS, TO_NUMBER (NULL) KOS,
                TO_DATE (NULL) dapp, TO_DATE   (NULL) daos, TO_DATE   (NULL) dazs, d.wdate mdate,  TO_NUMBER (NULL) isp, '', '', u.okpo, u.nmk, d.cc_id, d.sdate, NULL
          FROM (SELECT * FROM cc_deal WHERE sos < 14 AND nd = TO_NUMBER (pul.Get ('ND')) ) d,
               (SELECT * FROM tips    WHERE tip NOT IN ('LIM','SD ','SL ','SLK','SLN', 'ISG')   ) t,
               vidd_tip v,  customer u
          WHERE    d.vidd = v.vidd AND d.rnk = u.rnk AND v.tip = t.tip 
            AND NOT EXISTS (SELECT 1 FROM accounts a2, nd_acc n2 WHERE a2.acc = n2.acc AND n2.nd = d.nd AND a2.tip = t.tip)
and NOT ( d.nd = d.NDG and t.tip in ('SS ', 'SN ', 'SNO', 'SNA', 'SP ', 'SPN', 'SDI', 'SPI' ) )  
          ) x;

GRANT SELECT ON BARS.CC_W017 TO BARS_ACCESS_DEFROLE;
                                                     	