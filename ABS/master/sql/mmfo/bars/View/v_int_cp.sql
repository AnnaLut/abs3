

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INT_CP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INT_CP ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INT_CP ("RUN_INT", "S_INT", "DATE_INT", "S_GOOD", "S_REASON", "DOK", "DNK", "KV", "NLS", "NMS", "NBS", "ACCC", "TIP", "ACC", "RNK", "ID", "ACR_DAT", "ACRA", "ACRB", "STP_DAT", "METR", "BASEY", "BASEM", "TT", "NLSA", "NMSA", "KVA", "NLSB", "NMSB", "KVB", "OB22", "OSTC", "DAPP", "BRANCH", "REF") AS 
  SELECT run_int,
            s_int,
            date_int,
            CASE
               WHEN date_int >= dok AND date_int <= dnk AND notvisa = 0 THEN 1
               WHEN date_int >= dok AND date_int <= dnk AND notvisa > 0 THEN 2
               ELSE 0
            END
               AS s_good,
            CASE
               WHEN date_int >= dok AND date_int <= dnk AND notvisa = 0
               THEN
                  'Нарахування ОК'
               WHEN date_int >= dok AND date_int <= dnk AND notvisa > 0
               THEN
                  'Незавізовані документи по рахунку R'
               WHEN NOT (date_int >= dok AND date_int <= dnk)
               THEN
                  'Не актуальний купонний період'
               ELSE
                  ''
            END
               AS s_reason,
            dok,
            dnk,
            kv,
            nls,
            nms,
            nbs,
            ACCC,
            tip,
            acc,
            rnk,
            id,
            ACR_DAT,
            acra,
            acrb,
            stp_DAT,
            METR,
            BASEY,
            BASEM,
            tt,
            NLSA,
            NMSA,
            KVA,
            NLSb,
            NMSb,
            KVb,
            ob22,
            ostc,
            dapp,
            branch,
            REF
       FROM (SELECT 0 run_int,
                      f_INT_CP (
                         8,
                         x.acc,
                         0,
                         x.ACR_DAT + 1,
                           LEAST (
                              NVL (
                                 x.stp_DAT,
                                 NVL (
                                    TO_DATE (pul.get ('cp_v_date'),
                                             'dd.mm.yyyy'),
                                    gl.bd)),
                              NVL (
                                 TO_DATE (pul.get ('cp_v_date'), 'dd.mm.yyyy'),
                                 gl.bd))
                         - 2,
                         ABS (x.ostc),
                         0)
                    / 100
                       AS s_int,
                    NVL (TO_DATE (pul.get ('cp_v_date'), 'dd.mm.yyyy'), gl.bd)
                       date_int,
                    (SELECT NVL (k.dok, k.dat_em)
                       FROM cp_deal d, cp_kod k
                      WHERE d.acc = x.Acc AND k.id = cpid)
                       dok,
                    (SELECT NVL (k.dnk, k.datp)
                       FROM cp_deal d, cp_kod k
                      WHERE d.acc = x.Acc AND k.id = cpid)
                       dnk,
                    (SELECT COUNT (REF)
                       FROM opldok
                      WHERE acc = x.accr AND sos > 0 AND sos < 5)
                       AS notvisa,
                    x.kv,
                    x.nls,
                    x.nms,
                    x.nbs,
                    x.ACCC,
                    x.tip,
                    x.acc,
                    x.rnk,
                    x.id,
                    x.ACR_DAT,
                    x.acra,
                    x.acrb,
                    x.stp_DAT,
                    x.METR,
                    x.BASEY,
                    x.BASEM,
                    x.tt,
                    aa.nls NLSA,
                    aa.nms NMSA,
                    aa.kv KVA,
                    bb.nls NLSb,
                    bb.nms NMSb,
                    bb.kv KVb,
                    x.ob22,
                    x.ostc / 100 ostc,
                    x.dapp,
                    x.branch,
                    x.accr,
                    x.REF
               FROM accounts aa,
                    accounts bb,
                    (SELECT a.kv,
                            a.nls,
                            a.nms,
                            a.nbs,
                            a.ACCC,
                            a.tip,
                            a.acc,
                            a.rnk,
                            a.ob22,
                            a.ostc,
                            a.dapp,
                            i.id,
                            cd.id cpid,
                            GREATEST (a.daos - 1, i.acr_dat) ACR_DAT,
                            i.acra,
                            i.acrb,
                            i.stp_DAT,
                            i.METR,
                            i.BASEY,
                            i.BASEM,
                            i.tt,
                            a.branch,
                            ca.CP_ref REF,
                            car.cp_acc accr
                       FROM int_accn i,
                            cp_accounts ca,
                            accounts a,
                            cp_deal cd,
                            cp_accounts car
                      WHERE     a.acc = i.acc
                            AND a.acc = ca.cp_acc
                            AND ca.cp_ref = car.cp_ref
                            AND car.cp_acctype = 'R'
                            AND a.acc = cd.acc
                            AND a.dazs IS NULL
                            AND (   i.metr IN (0,
                                               1,
                                               2,
                                               3,
                                               4,
                                               5,
                                               7,
                                               8,
                                               10,
                                               12,
                                               23,
                                               515)
                                 OR i.metr > 90)
                            AND i.id NOT IN (10, 11)) x
              WHERE x.acra = aa.acc AND x.acrb = bb.acc)
      WHERE s_int != 0
   ORDER BY s_good DESC;

PROMPT *** Create  grants  V_INT_CP ***
grant SELECT                                                                 on V_INT_CP        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INT_CP.sql =========*** End *** =====
PROMPT ===================================================================================== 
