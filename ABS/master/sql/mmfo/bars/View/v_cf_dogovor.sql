

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CF_DOGOVOR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CF_DOGOVOR ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CF_DOGOVOR ("ND", "OKPO", "PASPNUM", "BIRTHDATE", "MFONUM", "FIO", "RNK", "DNUM", "DSYSTEM", "DBRANCH", "DSTATUS", "DCUR", "DTAX", "DSUM", "DSTARTDATE", "DFINISHDATE", "DLMPAYMENT") AS 
  SELECT cc.nd,
          c.okpo AS okpo,
          p.numdoc AS paspnum,
          p.bday AS birthdate,
          cc.kf AS mfonum,
          c.nmk AS fio,
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
                                 FROM bars.nd_acc n,
                                      bars.accounts a,
                                      bars.int_accn i
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
             AS dlmpayment
     FROM bars.cc_deal cc, bars.customer c, bars.person p
    WHERE     cc.rnk = c.rnk
          AND c.rnk = p.rnk
          AND cc.wdate > ADD_MONTHS (SYSDATE, -36)
          AND cc.branch LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask')
   UNION ALL
   SELECT ND,
          OKPO,
          PASPNUM,
          BIRTHDATE,
          MFONUM,
          FIO,
          RNK,
          DNUM,
          DSYSTEM,
          DBRANCH,
          DSTATUS,
          DCUR,
          DTAX,
          DSUM,
          DSTARTDATE,
          DFINISHDATE,
          DLMPAYMENT
     FROM (SELECT t1.nd AS nd,
                  t3.okpo AS okpo,
                  t4.numdoc AS paspnum,
                  T4.BDAY AS BIRTHDATE,
                  T1.KF AS MFONUM,
                  T3.NMK AS FIO,
                  t1.rnk AS rnk,
                  TO_CHAR (t1.nd) AS DNUM,
                  t1.branch AS DBRANCH,
                  'WAY4' AS DSYSTEM,
                  NULL AS DSTATUS,
                  t1.kv AS DCUR,
                  NULL AS DTAX,
                  T1.DSUM AS DSUM,
                  t1.ddate AS DSTARTDATE,
                  t1.DAT_end AS DFINISHDATE,
                  NULL AS DLMPAYMENT
             FROM (SELECT b.nd,
                          a.kf,
                          a.branch,
                          a.rnk,
                          a.kv,
                          COALESCE (a.LIM, 0) AS dsum,
                          b.DAT_BEGIN AS ddate,
                          b.DAT_end
                     FROM    BARS.W4_ACC b
                          JOIN
                             BARS.ACCOUNTS a
                          ON (a.acc = b.acc_pk)
                    WHERE     COALESCE (ACC_9129,
                                        ACC_OVR,
                                        ACC_2208,
                                        ACC_2207,
                                        ACC_2209,
                                        0) > 0
                          AND 1 <=
                                 (SELECT COUNT (1) -- є хоча б один не закритий рахунок
                                    FROM BARS.ACCOUNTS
                                   WHERE     ACC IN
                                                (ACC_9129,
                                                 ACC_OVR,
                                                 ACC_2208,
                                                 ACC_2207,
                                                 ACC_2209)
                                         AND DAZS IS NULL)) t1,
                  customer t3,
                  person t4
            WHERE     t1.rnk = t3.rnk
                  AND t3.rnk = t4.rnk
                  AND t4.passp = 1
                  AND t1.branch LIKE
                         SYS_CONTEXT ('bars_context', 'user_branch_mask'));

PROMPT *** Create  grants  V_CF_DOGOVOR ***
grant SELECT                                                                 on V_CF_DOGOVOR    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CF_DOGOVOR.sql =========*** End *** =
PROMPT ===================================================================================== 
