

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V ("BAL_VAR", "SOS", "ND", "DATD", "SUMB", "DAZS", "TIP", "REF", "ID", "CP_ID", "MDATE", "IR", "ERAT", "RYN", "VIDD", "KV", "ACC", "ACCD", "ACCP", "ACCR", "ACCR2", "ACCR3", "ACCUNREC", "ACCS", "ACCEXPR", "OSTA", "OSTD", "OSTP", "OSTR", "OSTR2", "OSTR3", "OSTUNREC", "OSTEXPN", "OSTEXPR", "OSTS", "OSTAB", "OSTAF", "EMI", "DOX", "RNK", "PF", "PFNAME", "DAPP", "DATP", "OST_2VD", "OST_2VP", "ZAL", "COUNTRY") AS 
  SELECT (  osta
           + ostd
           + ostp
           + ostr
           + ostr2
           + ostr3
           + ostunrec
           + osts
           + OST_2VD
           + OST_2VP
           + OSTEXPN
           + OSTEXPR)
             BAL_VAR,
          sos,
          nd,
          datd,
          sumb,
          dazs,
          tip,
          REF,
          ID,
          cp_id,
          mdate,
          ir,
          erat,
          ryn,
          vidd,
          kv,
          acc,
          accd,
          accp,
          accr,
          accr2,
          accr3,
          accunrec,
          accs,
          accexpr,
          osta,
          ostd,
          ostp,
          ostr,
          ostr2,
          ostr3,
          OSTUNREC,
          OSTEXPN,
          OSTEXPR,
          osts,
          ostab,
          ostaf,
          emi,
          dox,
          rnk,
          pf,
          pfname,
          dapp,
          datp,
          OST_2VD,
          OST_2VP,
          TO_NUMBER (GET_ACCW (ACC,
                               NULL,
                               NULL,
                               NULL,
                               'CP_ZAL',
                               NULL))
             zal,
          country
     FROM (SELECT o.sos,
                  o.nd,
                  o.datd,
                  o.s / 100 SUMB,
                  a.dazs,
                  k.tip,
                  e.REF,
                  k.ID,
                  k.cp_id,
                  k.datp MDATE,
                  k.ir,
                  ROUND (DECODE (e.erate, NULL, e.erat * 100 * 365, e.erat),
                         4)
                     ERAT,
                  e.ryn,
                  v.vidd,
                  a.kv,
                  a.acc,
                  d.acc ACCD,
                  p.acc ACCP,
                  r.acc ACCR,
                  r2.acc ACCR2,
                  r3.acc ACCR3,
                  runrec.acc ACCUNREC,
                  EXPN.acc ACCEXPN,
                  EXPR.acc ACCEXPR,
                  s.acc ACCS,
                  NVL (a.ostc, 0) / 100 OSTA,
                  DECODE (k.dox, 1, 0, NVL (d.ostc, 0)) / 100 OSTD,
                  DECODE (k.dox, 1, 0, NVL (p.ostc, 0)) / 100 OSTP,
                  NVL (r.ostc, 0) / 100 OSTR,
                  NVL (r2.ostc, 0) / 100 OSTR2,
                  NVL (r3.ostc, 0) / 100 OSTR3,
                  NVL (runrec.ostc, 0) / 100 OSTUNREC,
                  NVL (EXPN.ostc, 0) / 100 OSTEXPN,
                  NVL (EXPR.ostc, 0) / 100 OSTEXPR,
                  NVL (s.ostc, 0) / 100 OSTS,
                  NVL (a.ostb, 0) / 100 OSTAB,
                  NVL (a.ostb + a.ostf, 0) / 100 OSTAF,
                  k.emi,
                  k.dox,
                  k.rnk,
                  v.pf,
                  cp.NAME PFNAME,
                  NVL (a.dapp, a.daos) DAPP,
                  o.datp,
                  (SELECT NVL (SUM (a2d.ostc), 0) / 100
                     FROM cp_ref_acc c2d, accounts a2d
                    WHERE     c2d.REF = e.REF
                          AND a2d.acc = c2d.acc
                          AND a2d.tip = '2VD')
                     OST_2VD,
                  (SELECT NVL (SUM (a2p.ostc), 0) / 100
                     FROM cp_ref_acc c2p, accounts a2p
                    WHERE     c2p.REF = e.REF
                          AND a2p.acc = c2p.acc
                          AND a2p.tip = '2VP')
                     OST_2VP,
                  country
             FROM cp_kod k,
                  cp_deal e,
                  accounts a,
                  accounts d,
                  accounts p,
                  accounts r,
                  accounts r2,
                  accounts r3,
                  accounts runrec,
                  accounts EXPN,
                  accounts EXPR,
                  accounts s,
                  cp_vidd v,
                  cp_pf cp,
                  oper o
            WHERE     v.vidd IN
                         (SUBSTR (a.nls, 1, 4),
                          NVL (SUBSTR (p.nls, 1, 4), ''))
                  AND o.REF = e.REF
                  AND k.ID = e.ID
                  AND a.acc = e.acc
                  AND d.acc(+) = e.accd
                  AND p.acc(+) = e.accp
                  AND r.acc(+) = e.accr
                  AND r2.acc(+) = e.accr2
                  AND r3.acc(+) = e.accr3
                  AND runrec.acc(+) = e.ACCUNREC
                  AND expn.acc(+) = e.ACCEXPN
                  AND expr.acc(+) = e.ACCEXPR
                  AND s.acc(+) = e.accs
                  AND v.pf = cp.pf
                  AND v.emi = k.emi
           UNION ALL
           SELECT *
             FROM (SELECT o.sos,
                          o.nd,
                          a0.daos,
                          NVL (cpa.ostc, 0) / 100 + NVL (cpa.ostcr, 0) / 100
                             SUMB,
                          a.dazs,
                          k.tip,
                          e.REF,
                          k.ID,
                          k.cp_id,
                          k.datp MDATE,
                          k.ir,
                          0 ERAT,
                          e.ryn,
                          3541,
                          a.kv,
                          a.acc,
                          NULL ACCD,
                          NULL ACCP,
                          NULL ACCR,
                          NULL ACCR2,
                          NULL ACCR3,
                          NULL OSTUNREC,
                          NULL ACCEXPN,
                          NULL ACCEXPR,
                          NULL ACCS,
                          NVL (cpa.ostc, 0) / 100 OSTA,
                          0 OSTD,
                          0 OSTP,
                          NVL (cpa.ostcr, 0) / 100 OSTR,
                          0 OSTR2,
                          0 OSTR3,
                          0 OSTRUNREC,
                          0 OSTEXPN,
                          0 OSTEXPR,
                          0 OSTS,
                          0 OSTAB,
                          0 OSTAF,
                          k.emi,
                          k.dox,
                          k.rnk,
                          -3,
                          'Портфель ФД',
                          NVL (a.dapp, a.daos) DAPP,
                          o.datp,
                          0 OST_2VD,
                          0 OST_2VP,
                          country
                     FROM cp_kod k,
                          cp_deal e,
                          accounts a,
                          accounts a0,
                          cp_accounts cpa,
                          cp_ryn cr,
                          oper o
                    WHERE     o.REF = e.REF
                          AND k.ID = e.ID
                          AND a.acc = e.acc
                          AND a0.acc = a.accc
                          AND a.acc = cpa.cp_acc
                          AND cpa.cp_acctype = 's3541'
                          AND e.REF IN (  SELECT cp_ref
                                            FROM cp_accounts
                                        GROUP BY cp_ref
                                          HAVING COUNT (cp_ref) = 1)
                          AND e.ryn = cr.ryn
                          AND CR.QUALITY = -1
                   UNION
                     SELECT o.sos,
                            o.nd,
                            o.datd,
                            SUM ( (SELECT ostc / 100
                                     FROM accounts
                                    WHERE acc = cpa.cp_acc))
                               SUMB,
                            o.datd,
                            k.tip,
                            e.REF,
                            k.ID,
                            k.cp_id,
                            k.datp MDATE,
                            k.ir,
                            ROUND (
                               DECODE (e.erate,
                                       NULL, e.erat * 100 * 365,
                                       e.erat),
                               4)
                               ERAT,
                            e.ryn,
                            3541,
                            a.kv,
                            a.acc,
                            NULL ACCD,
                            NULL ACCP,
                            NULL ACCR,
                            NULL ACCR2,
                            NULL ACCR3,
                            NULL OSTUNREC,
                            NULL ACCEXPN,
                            NULL ACCEXPR,
                            NULL ACCS,
                            SUM (CASE
                                    WHEN cpa.cp_acctype = 'N'
                                    THEN
                                       (SELECT ostc / 100
                                          FROM accounts
                                         WHERE acc = cpa.cp_acc)
                                    ELSE
                                       0
                                 END)
                               OSTA,
                            0 OSTD,
                            0 OSTP,
                            SUM (CASE
                                    WHEN cpa.cp_acctype = 'R'
                                    THEN
                                       (SELECT ostc / 100
                                          FROM accounts
                                         WHERE acc = cpa.cp_acc)
                                    ELSE
                                       0
                                 END)
                               OSTR,
                            0 OSTR2,
                            0 OSTR3,
                            0 OSTRUNREC,
                            0 OSTEXPN,
                            0 OSTEXPR,
                            0 OSTS,
                            0 OSTAB,
                            0 OSTAF,
                            k.emi,
                            k.dox,
                            k.rnk,
                            -3,
                            'Портфель ФД',
                            NVL (a.dapp, a.daos) DAPP,
                            o.datp,
                            0 OST_2VD,
                            0 OST_2VP,
                            country
                       FROM cp_kod k,
                            cp_deal e,
                            accounts a,
                            accounts a0,
                            cp_accounts cpa,
                            cp_ryn cr,
                            oper o
                      WHERE     o.REF = e.REF
                            AND k.ID = e.ID
                            AND a.acc = e.acc
                            AND a0.acc = a.accc
                            AND e.REF = cpa.cp_ref
                            AND e.ryn = cr.ryn
                            AND e.REF IN (  SELECT cp_ref
                                              FROM cp_accounts
                                          GROUP BY cp_ref
                                            HAVING COUNT (cp_ref) > 1)
                            AND CR.QUALITY = -1
                   GROUP BY o.sos,
                            o.nd,
                            a0.daos,
                            a.dazs,
                            e.erat,
                            e.erate,
                            o.datd,
                            k.tip,
                            e.REF,
                            k.ID,
                            k.cp_id,
                            k.datp,
                            k.ir,
                            e.ryn,
                            a.kv,
                            a.acc,
                            k.emi,
                            a.dapp,
                            a.daos,
                            k.dox,
                            k.rnk,
                            o.datp,
                            country));

PROMPT *** Create  grants  CP_V ***
grant SELECT                                                                 on CP_V            to BARSREADER_ROLE;
grant SELECT                                                                 on CP_V            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_V            to CP_ROLE;
grant SELECT                                                                 on CP_V            to START1;
grant SELECT                                                                 on CP_V            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V.sql =========*** End *** =========
PROMPT ===================================================================================== 
