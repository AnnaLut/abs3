

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CF_DOGOVOR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CF_DOGOVOR ***

CREATE OR REPLACE FORCE VIEW BARS.V_CF_DOGOVOR
(
   "ND",
   "OKPO",
   "PASPNUM",
   "BIRTHDATE",
   "MFONUM",
   "FIO",
   "INSIDER",
   "PUB",
   "RNKDATECR",
   "RNK",
   "DNUM",
   "DSYSTEM",
   "DBRANCH",
   "DSTATUS",
   "DCUR",
   "DTAX",
   "DSUM",
   "DNEXTPAYM",
   "DSTARTDATE",
   "DFINISHDATE",
   "DLMPAYMENT",
   "DPAWN",
   "DCODE",
   "DOCTYPE"
)
AS
   SELECT cc.nd,
          c.okpo AS okpo,
          p.numdoc AS paspnum,
          p.bday AS birthdate,
          cc.kf AS mfonum,
          c.nmk AS fio,
          C.PRINSIDER INSIDER,
            (SELECT CASE WHEN COUNT (1) > 0 THEN 'Y' ELSE 'N' END
               FROM customer_risk
              WHERE rnk = c.rnk AND dat_end IS NULL) as PUB,
		  c.date_on as RNKDATECR,
          cc.rnk AS rnk,
          cc.cc_id AS dnum,
          'ABS' AS dsystem,
          cc.branch AS dbranch,
          (SELECT cs.name
             FROM bars.cc_sos cs
            WHERE cs.sos = cc.sos)
             AS dstatus,
          (SELECT a.kv
             FROM bars.nd_acc na, bars.accounts a
            WHERE     na.nd = cc.nd
                  AND na.acc = a.acc
                  AND a.nls LIKE '8999%'
                  AND a.tip = 'LIM')
             AS dcur,
          (SELECT rate
             FROM (  SELECT acrn.fprocn (acc, 0, bars.bankdate_g) rate, nd
                       FROM (  SELECT a.acc, n.nd
                                 FROM bars.accounts a,
                                      bars.int_accn i,
                                      bars.nd_acc n
                                WHERE     n.acc = a.acc
                                      AND a.tip IN (UPPER ('ss'), UPPER ('lim'))
                                      AND (SELECT COUNT (1)
                                             FROM bars.saldoa sa
                                            WHERE sa.acc = a.acc) != 0
                                      AND A.DAZS IS NULL
                                      AND i.id = 0
                                      AND i.acc = a.acc
                             ORDER BY DECODE (
                                         bars.acrn.fprocn (a.acc,
                                                           0,
                                                           bars.bankdate_g),
                                         0, 0,
                                         1),
                                      a.daos DESC)
                   ORDER BY rate DESC)
            WHERE nd = cc.nd AND ROWNUM = 1)
             AS dtax,
          (SELECT SUM (NVL (sdog * 100, 0))
             FROM bars.cc_deal
            WHERE nd = cc.nd)
             AS dsum,
           (select nvl(( SELECT sumo
                               FROM bars.cc_lim
                              WHERE     nd = cc.nd 
                                    AND fdat =
                                           (SELECT min (fdat)
                                              FROM bars.cc_lim l
                                             WHERE     l.fdat > gl.bd
                                                   AND l.nd =cc.nd
                                                   AND l.sumo != 0)),0)/100
            from dual) as DNEXTPAYM,
          cc.sdate AS dstartdate,
          cc.wdate AS dfinishdate,
          (SELECT (CASE
                      WHEN cc.vidd IN (12, 13)
                      THEN
                         NULL
                      ELSE
                         NVL (
                            (SELECT sumo
                               FROM bars.cc_lim
                              WHERE     nd = cc.nd
                                    AND fdat =
                                           (SELECT MAX (fdat)
                                              FROM bars.cc_lim l
                                             WHERE     l.fdat <
                                                          TRUNC (
                                                             ADD_MONTHS (
                                                                bars.bankdate_g,
                                                                -1))
                                                   AND l.nd = cc.nd
                                                   AND l.sumo != 0)),
                            0)
                   END)
             FROM DUAL)
             AS dlmpayment,
          (SELECT pc.pawn
             FROM cc_accp p, pawn_acc pc
            WHERE p.nd = cc.nd AND pc.acc = p.acc AND ROWNUM = 1)
             AS dpawn,
           substr(cc.prod,1,6) as  DCODE,
		   p.passp as DOCTYPE
     FROM bars.cc_deal cc, bars.customer c, bars.person p
    WHERE     cc.rnk = c.rnk
          AND c.rnk = p.rnk
          AND cc.wdate > ADD_MONTHS (SYSDATE, -36)
   UNION ALL
   SELECT ND,
          OKPO,
          PASPNUM,
          BIRTHDATE,
          MFONUM,
          FIO,
          INSIDER,
          PUB,
		  RNKDATECR,
          RNK,
          DNUM,
          DSYSTEM,
          DBRANCH,
          DSTATUS,
          DCUR,
          DTAX,
          DSUM,
          DNEXTPAYM,
          DSTARTDATE,
          DFINISHDATE,
          DLMPAYMENT,
          dpawn,
          DCODE,
		  DOCTYPE
     FROM (SELECT t1.nd AS nd,
                  t3.okpo AS okpo,
                  t4.numdoc AS paspnum,
                  T4.BDAY AS BIRTHDATE,
                  T1.KF AS MFONUM,
                  T3.NMK AS FIO,
                  T3.PRINSIDER INSIDER                  ,
                  (SELECT CASE WHEN COUNT (1) > 0 THEN 'Y' ELSE 'N' END
                       FROM customer_risk
                      WHERE rnk = t3.rnk AND dat_end IS NULL) as PUB,
				  T3.DATE_ON as RNKDATECR,
                  t1.rnk AS rnk,
                  TO_CHAR (t1.nd) AS DNUM,
                  t1.branch AS DBRANCH,
                  'WAY4' AS DSYSTEM,
                  NULL AS DSTATUS,
                  t1.kv AS DCUR,
                  NULL AS DTAX,
                  T1.DSUM AS DSUM,
                  0 as  DNEXTPAYM,
                  t1.ddate AS DSTARTDATE,
                  t1.DAT_end AS DFINISHDATE,
                  NULL AS DLMPAYMENT,
                  (SELECT pc.pawn
                     FROM cc_accp p, pawn_acc pc
                    WHERE p.nd = t1.nd AND pc.acc = p.acc AND ROWNUM = 1)
                     AS dpawn,
                  null as DCODE,
				  t4.passp as DOCTYPE
             FROM (SELECT b.nd,
                          a.kf,
                          a.branch,
                          a.rnk,
                          a.kv,
                          CASE
                             WHEN (    b.acc_ovr IS NOT NULL
                                   AND b.acc_9129 IS NOT NULL)
                             THEN
                                (SELECT (a1.ostc + A2.OSTC) * -1
                                   FROM accounts a1, accounts a2
                                  WHERE     a1.acc = b.acc_ovr
                                        AND a2.acc = b.acc_9129)
                             ELSE
                                COALESCE (a.LIM, 0)
                          END
                             dsum,
                          b.DAT_BEGIN AS ddate,
                          b.DAT_end,
                          b.acc_pk
                     FROM BARS.W4_ACC b
                          JOIN BARS.ACCOUNTS a ON (a.acc = b.acc_pk)
                    WHERE     COALESCE (ACC_9129,
                                        ACC_OVR,
                                        ACC_2208,
                                        ACC_2207,
                                        ACC_2209,
                                        0) > 0
                          AND 1 <= (SELECT COUNT (1) -- є хоча б один не закритий рахунок
                                      FROM BARS.ACCOUNTS
                                     WHERE     ACC IN (ACC_9129,
                                                       ACC_OVR,
                                                       ACC_2208,
                                                       ACC_2207,
                                                       ACC_2209)
                                           AND DAZS IS NULL)) t1,
                  customer t3,
                  person t4
            WHERE t1.rnk = t3.rnk AND t3.rnk = t4.rnk);


PROMPT *** Create  grants  V_CF_DOGOVOR ***
grant SELECT                                                                 on V_CF_DOGOVOR    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CF_DOGOVOR.sql =========*** End *** =
PROMPT ===================================================================================== 
