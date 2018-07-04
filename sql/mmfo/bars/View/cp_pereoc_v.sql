

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_PEREOC_V.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_PEREOC_V ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_PEREOC_V ("SOS", "ND", "DATD", "SUMB", "DAZS", "DATP_A", "FL_REPO", "TIP", "REF", "ID", "NAME", "CP_ID", "MDATE", "CENA", "IR", "ERAT", "RYN", "VIDD", "KV", "KOL", "KOL_CP", "N", "N1", "D", "D1", "P", "P1", "R", "R1", "R2", "S", "BAL_VAR", "UNREC1", "R21", "R31", "EXPR1", "EXPN1", "KOLK", "BAL_VAR1", "NKD1", "RATE_B", "K20", "K21", "K22", "OSTR", "OSTR_F", "OSTAF", "OSTS_P", "EMI", "DOX", "RNK", "PF", "PFNAME", "DAT_ZV", "DAPP", "DATP", "QUOT_SIGN", "FL_ALG", "DATREZ23", "REZ23", "PEREOC23", "FL_ALG23", "OPCION", "NLS", "S2", "S2_P") AS 
SELECT SOS,
          ND,
          DATD,
          SUMB,
          DAZS,
          DATP_A,
          DECODE (datp_a, mdate, 0, 1) FL_REPO,
          TIP,
          REF,
          ID,
          NAME,
          CP_ID,
          MDATE,
          CENA,
          IR,
          round(ERAT,6),
          RYN,
          VIDD,
          KV,
          ABS (NVL (N / CENA, 1)) kol,
          kol1 KOL_CP,
          N,
          N1,
          D,
          D1,
          P,
          P1,
          (R + UNREC) R,
          r1,
          R2,
          S,
          CASE
             WHEN kv = 980
             THEN
                (N + D + P + (R + UNREC) + R2 + R3 + expR + expN + S) * (-1)
             ELSE
                (N + D + P + (R + UNREC) + R2 + R3 + expR + expN) * (-1)
          END
             bal_var,
          UNREC1,
          R21,
          r31,
          expr1,
          expn1,
          kolk,
          round(CASE
             WHEN kv = 980
             THEN
                ABS (
                   (N + D + P + (R + UNREC) + R2 + R3 + expR + expN + s)
                   / (N / CENA))
             ELSE
                ABS (
                   (N + D + P + (R + UNREC) + R2 + R3 + expR + expN)
                   / (N / CENA))
          END,6)
             bal_var1,
          ABS (ROUND ( ( (R + UNREC) + R2 + R3) / kol1, 2)) NKD1,
          rate_b K19,
          round(rate_b
          + DECODE (fl_alg,
                    1, 0,
                    2, ABS (ROUND ( ( (R + UNREC) + R2 + R3) / kol1, 2)),
                    0),6)
             K20,
          round(DECODE (
             fl_alg,
             1, (rate_b
                 - ABS (
                      ROUND (
                         (  N
                          + D
                          + P
                          + (R + UNREC)
                          + R2
                          + R3
                          + expR
                          + expN
                          + (CASE WHEN kv = 980 THEN S ELSE 0 END))
                         / ABS (NVL (N / CENA, 1)),
                         2))),
             2, ABS (ROUND ( ( (R + UNREC) + R2 + R3) / kol1, 2)) + rate_b
                - ABS (
                     ROUND (
                        (  N
                         + D
                         + P
                         + (R + UNREC)
                         + R2
                         + R3
                         + expR
                         + expN
                         + (CASE WHEN kv = 980 THEN S ELSE 0 END))
                        / ABS (NVL (N / CENA, 1)),
                        2)),
             0),6)
             K21,
          round(DECODE (
             fl_alg,
             1, (rate_b
                 - ABS (
                      (  N
                       + D
                       + P
                       + (R + UNREC)
                       + R2
                       + R3
                       + expR
                       + expN
                       + (CASE WHEN kv = 980 THEN S ELSE 0 END))
                      / ABS (NVL (N / CENA, 1))))
                * kol1,
             2, (rate_b + ABS (ROUND ( ( (R + UNREC) + R2 + R3) / kol1, 2))
                 - ABS (
                      (  N
                       + D
                       + P
                       + (R + UNREC)
                       + R2
                       + R3
                       + expR
                       + expN
                       + (CASE WHEN kv = 980 THEN S ELSE 0 END))
                      / ABS (NVL (N / CENA, 1))))
                * kol1,
             0),6)
             K22,
          OSTR R,
          ostr_f,
          OSTAF,
          OSTS_P,
          EMI,
          DOX,
          RNK,
          PF,
          PFNAME,
          bankdate dat_zv,
          DAPP,
          DATP,
          quot_sign,
          fl_alg,
          ROUND (gl.bd, 'MM') DATREZ23,
          REZ23,
          f_cp_pereoc23 (p_fl_alg23   => fl_alg23,
                         p_rez23      => t.rez23,
                         p_n1         => N1,
                         p_d1         => D1,
                         p_p1         => p1,
                         p_r1         => r1,
                         p_unrec1     => unrec1,
                         p_r21        => r21,
                         p_r31        => r31,
                         p_expr1      => expr1,
                         p_expn1      => expn1,
                         p_cena       => cena,
                         p_kolk       => kolk)
             PEREOC23,
          fl_alg23,
--          round(DECODE (fl_alg, 3, (rate_b - abs(s2))*kol1, 0),6) OPCION,--переоцінку будемо робити не нарізницю, а з розформуванням попередньої
          round(DECODE (fl_alg, 3, rate_b*kol1, 0),6) OPCION,   
          NLS,
          S2,
          S2_P
     FROM (SELECT o.sos,
                  o.nd,
                  o.datd,
                  o.s / 100 SUMB,
                  a.dazs,
                  a.mdate datp_a,
                  k.tip,
                  e.REF,
                  k.ID,
                  k.name,
                  k.cp_id,
                  k.datp MDATE,
                  k.cena,
                  k.ir,
                  e.erat,
                  e.ryn,
                  v.vidd,
                  k.kv,
                  ABS (NVL (fost (a.acc, bankdate) / (CENA * 100), 1)) kol1,
                  ABS (
                     NVL (ost_korr (a.acc,
                                    dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                    NULL,
                                    SUBSTR (a.nls, 1, 4))
                          / (CENA * 100),
                          1))
                     kolk,
                  accr,
                  a.ostc / 100 N,
                  ost_korr (a.acc,
                            dat_last_work (ROUND (gl.bd, 'MM') - 1),
                            NULL,
                            SUBSTR (a.nls, 1, 4))
                  / 100
                     N1,
                  NVL (d.ostc, 0) / 100 D,
                  NVL (ost_korr (d.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (d.nls, 1, 4)),
                       0)
                  / 100
                     D1,
                  NVL (p.ostc, 0) / 100 P,
                  NVL (ost_korr (p.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (p.nls, 1, 4)),
                       0)
                  / 100
                     P1,
                  NVL (r.ostc, 0) / 100 R,
                  NVL (ost_korr (r.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (r.nls, 1, 4)),
                       0)
                  / 100
                     R1,
                  NVL (unrec.ostc, 0) / 100 UNREC,
                  NVL (ost_korr (unrec.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (unrec.nls, 1, 4)),
                       0)
                  / 100
                     UNREC1,
                  NVL (expr.ostc, 0) / 100 expR,
                  NVL (ost_korr (expr.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (expr.nls, 1, 4)),
                       0)
                  / 100
                     expR1,
                  NVL (expn.ostc, 0) / 100 expN,
                  NVL (ost_korr (expn.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (expn.nls, 1, 4)),
                       0)
                  / 100
                     expN1,
                  (NVL (r.ostc, 0) / 100) - (NVL (unrec.ostc, 0) / 100) OSTR,
                  NVL (r.ostb + r.ostf, 0) / 100 OSTR_F,
                  NVL (ost_korr (r2.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (r2.nls, 1, 4)),
                       0)
                  / 100
                     R21,
                  NVL (r2.ostc, 0) / 100 R2,
                  NVL (r3.ostc, 0) / 100 R3,
                  NVL (ost_korr (r3.acc,
                                 dat_last_work (ROUND (gl.bd, 'MM') - 1),
                                 NULL,
                                 SUBSTR (r3.nls, 1, 4)),
                       0)
                  / 100
                     R31,
                  NVL (a.ostb + a.ostf, 0) / 100 OSTAF,
                  NVL (s.ostc, 0) / 100 S,
                  NVL (s.ostc, 0) / 100 OSTS,
                  NVL (s.ostb, 0) / 100 OSTS_P,
                  k.emi,
                  k.dox,
                  k.rnk,
                  v.pf,
                  cp.NAME PFNAME,
                  NVL (c.rate_b, 0) rate_b,
                  NVL (a.dapp, a.daos) DAPP,
                  o.datp,
                  NVL (c.quot_sign, 0) quot_sign,
                  NVL (c.fl_alg, 0) FL_ALG,
                  f_cp_pereoc (e.REF, ROUND (gl.bd, 'MM'), 1) FL_ALG23,
                  f_cp_pereoc (e.REF, ROUND (gl.bd, 'MM'), 2) REZ23,
                  a.nls,
                  NVL (s2.ostc, 0) / 100 S2,
                  NVL (s2.ostb, 0) / 100 S2_P
             FROM cp_kod k,
                  cp_deal e,
                  accounts a,
                  accounts d,
                  accounts p,
                  accounts r,
                  accounts r2,
                  accounts r3,
                  accounts s,
                  accounts expr,
                  accounts expn,
                  accounts unrec,
                  cp_rates_sb c,
                  cp_vidd v,
                  cp_pf cp,
                  oper o,
                  (select a.ostc, a.ostb ,ca.cp_ref from cp_accounts ca, accounts a where ca.cp_acc = a.acc and ca.cp_acctype = 'S2') s2
            WHERE v.vidd IN
                     (SUBSTR (a.nls, 1, 4), NVL (SUBSTR (p.nls, 1, 4), ''))
                  AND o.REF = e.REF
                  AND o.sos > 0
                  AND k.ID = e.ID
                  AND k.cena IS NOT NULL
                  AND a.acc = e.acc
                  AND a.ostc != 0
                  AND d.acc(+) = e.accd
                  AND fost (a.acc, bankdate) != 0
                  AND p.acc(+) = e.accp
                  AND k.tip != 2
                  AND r.acc(+) = e.accr
                  AND r2.acc(+) = e.accr2
                  AND r3.acc(+) = e.accr3
                  AND expr.acc(+) = e.ACCEXPR
                  AND expn.acc(+) = e.ACCEXPN
                  AND unrec.acc(+) = e.ACCUNREC
                  AND s.acc = e.accs
                  AND cp.NO_P IS NULL
                  AND e.REF = c.REF(+)
                  AND v.pf = cp.pf
                  AND v.emi = k.emi
                  and e.ref = s2.cp_ref (+) ) t;

PROMPT *** Create  grants  CP_PEREOC_V ***
grant SELECT                                                                 on CP_PEREOC_V     to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on CP_PEREOC_V     to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_PEREOC_V     to CP_ROLE;
grant SELECT                                                                 on CP_PEREOC_V     to START1;
grant SELECT                                                                 on CP_PEREOC_V     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_PEREOC_V.sql =========*** End *** ==
PROMPT ===================================================================================== 
