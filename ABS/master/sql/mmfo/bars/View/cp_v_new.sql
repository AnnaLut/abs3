

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_NEW.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_NEW ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_NEW ("BAL_VAR", "KIL", "CENA", "SOS", "ND", "DATD", "SUMB", "DAZS", "TIP", "REF", "ID", "CP_ID", "MDATE", "IR", "ERAT", "RYN", "VIDD", "KV", "ACC", "ACCD", "ACCP", "ACCR", "ACCR2", "ACCR3", "ACCUNREC", "ACCS", "OSTA", "OSTD", "OSTP", "OSTR", "OSTR2", "OSTR3", "OSTUNREC", "OSTEXPN", "OSTEXPR", "OSTS", "OSTAB", "OSTAF", "EMI", "DOX", "RNK", "PF", "PFNAME", "DAPP", "DATP", "NO_PR", "OST_2VD", "OST_2VP", "ZAL", "COUNTRY", "NO_P", "ACTIVE", "OSTRD", "OSTS2", "OSTSDM") AS 
  WITH dd
        AS (SELECT TO_DATE (pul.get ('cp_v_date'), 'dd.mm.yyyy') d FROM DUAL)
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
           + OSTEXPR
           + OSTSDM
           + osts2)
             BAL_VAR,
          ROUND (
             (  (FOSTZN (acc, COALESCE (dd.d, gl.bd))+ (FOSTZN (accexpn, COALESCE (dd.d, gl.bd))))
              / NULLIF (F_CENA_CP (id, COALESCE (dd.d, gl.bd), 0), 0)
              * DECODE (tip, 1, -1, 1)
              / 100),
             0) 
             AS KIL,
          F_CENA_CP (id, COALESCE (dd.d, gl.bd), 0) cena,
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
          (SELECT name
             FROM cp_ryn
            WHERE ryn = p_ryn),
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
          osta,
          ostd,
          ostp,
          ostr,-- + OSTUNREC,
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
          IR NO_PR,
          OST_2VD,
          OST_2VP,
          cp.get_from_cp_zal_kolz (ref, COALESCE (dd.d, gl.bd)) zal,          
          country,
          NO_P,
          ACTIVE,
          (NVL (fost (acc_rd, COALESCE (dd.d, gl.bd)), 0) / 100) ostrd,
          osts2,
          ostsdm
     FROM dd,
          (SELECT o.sos,
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
                  e.ryn p_ryn,
                  v.vidd,
                  a.kv,
                  a.acc,
                  e.accd ACCD,
                  e.accp ACCP,
                  e.accr ACCR,
                  e.accr2 ACCR2,
                  e.accr3 ACCR3,
                  e.accunrec ACCUNREC,
                  e.accEXPN ACCEXPN,
                  e.accEXPR ACCEXPR,
                  s.acc ACCS,
                  NVL (fost (a.acc, COALESCE (dd.d, gl.bd)), 0) / 100 OSTA,
                    DECODE (k.dox,
                            1, 0,
                            NVL (fost (e.accd, COALESCE (dd.d, gl.bd)), 0))
                  / 100
                     OSTD,
                    DECODE (k.dox,
                            1, 0,
                            NVL (fost (p.acc, COALESCE (dd.d, gl.bd)), 0))
                  / 100
                     OSTP,
                  NVL (fost (e.ACCr, COALESCE (dd.d, gl.bd)), 0) / 100 OSTR,
                  NVL (fost (e.ACCr2, COALESCE (dd.d, gl.bd)), 0) / 100 OSTR2,
                  NVL (fost (e.ACCr3, COALESCE (dd.d, gl.bd)), 0) / 100 OSTR3,
                  NVL (fost (e.ACCUNREC, COALESCE (dd.d, gl.bd)), 0) / 100
                     OSTUNREC,
                  NVL (fost (e.ACCEXPN, COALESCE (dd.d, gl.bd)), 0) / 100
                     OSTEXPN,
                  NVL (fost (e.ACCEXPR, COALESCE (dd.d, gl.bd)), 0) / 100
                     OSTEXPR,
                  NVL (fost (s.acc, COALESCE (dd.d, gl.bd)), 0) / 100 OSTS,
                  NVL (a.ostb, 0) / 100 OSTAB,
                  NVL (a.ostb + a.ostf, 0) / 100 OSTAF,
                  k.emi,
                  k.dox,
                  k.rnk,
                  v.pf,
                  cp.NAME PFNAME,
                  NVL (a.dapp, a.daos) DAPP,
                  o.datp,
                  (SELECT   NVL (
                               SUM (fost (a2d.acc, COALESCE (dd.d, gl.bd))),
                               0)
                          / 100
                     FROM cp_ref_acc c2d, accounts a2d
                    WHERE     c2d.REF = e.REF
                          AND a2d.acc = c2d.acc
                          AND a2d.tip = '2VD')
                     OST_2VD,
                  (SELECT   NVL (
                               SUM (fost (a2p.acc, COALESCE (dd.d, gl.bd))),
                               0)
                          / 100
                     FROM cp_ref_acc c2p, accounts a2p
                    WHERE     c2p.REF = e.REF
                          AND a2p.acc = c2p.acc
                          AND a2p.tip = '2VP')
                     OST_2VP,
                  country,
                  NVL (cp.no_p, 0) no_p,
                  LEAST (
                     CASE
                        WHEN o.sos > 0 AND o.sos < 5 THEN 0
                        WHEN o.sos = 5 THEN 1
                        WHEN o.sos < 0 THEN -1
                     END,
                     e.active)
                     AS active,
                 (select cp_acc from cp_accounts where cp_acctype = 'RD' and cp_ref = e.ref ) acc_rd,  
                 (select cp_acc from cp_accounts where cp_acctype = 'S2' and cp_ref = e.ref ) acc_s2,
		 (NVL (fost ((select cp_acc from cp_accounts where cp_acctype = 'S2' and cp_ref = e.ref ), COALESCE (dd.d, gl.bd)), 0) / 100) osts2,
                 (select NVL ( SUM (fost (cp_acc, COALESCE (dd.d, gl.bd))), 0) / 100  from cp_accounts where cp_acctype = 'SDM' and cp_ref = e.ref ) ostsdm
             FROM cp_kod k,
                  dd,
                  cp_deal e,
                  (SELECT *
                     FROM accounts t, cp_accounts ca
                    WHERE CA.CP_ACC = t.acc) a,
                  (SELECT *
                     FROM accounts t, cp_accounts ca
                    WHERE CA.CP_ACC = t.acc) p,
                  (SELECT *
                     FROM accounts t, cp_accounts ca
                    WHERE CA.CP_ACC = t.acc) s,
                  cp_vidd v,
                  cp_pf cp,
                  oper o
            WHERE     v.vidd IN
                         (SUBSTR (a.nls, 1, 4),
                          NVL (SUBSTR (p.nls, 1, 4), ''))
                  AND o.REF = e.REF
                  AND k.ID = e.ID
                  AND a.acc = e.acc
                  AND p.acc(+) = e.accp
                  AND s.acc(+) = e.accs
                  AND v.pf = cp.pf
                  AND v.emi = k.emi
           UNION ALL
           SELECT o.sos,
                  o.nd,
                  a0.daos,
                    NVL (fost (cpa.ostc, COALESCE (dd.d, gl.bd)), 0) / 100
                  + NVL (cpa.ostcr, 0) / 100
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
                  country,
                  0 no_p,
                  e.active,
                  null acc_rd,
                  null acc_s2,
	          0    osts2,
	          0    ostsdm
             FROM cp_kod k,
                  cp_deal e,
                  accounts a,
                  accounts a0,
                  cp_accounts cpa,
                  cp_ryn cr,
                  oper o,
                  dd
            WHERE     o.REF = e.REF
                  AND k.ID = e.ID
                  AND a.acc = e.acc
                  AND a0.acc = a.accc
                  AND a.acc = cpa.cp_acc
                  AND e.ryn = cr.ryn
                  AND CR.QUALITY = -1);

PROMPT *** Create  grants  CP_V_NEW ***
grant SELECT                                                                 on CP_V_NEW        to BARSREADER_ROLE;
grant SELECT                                                                 on CP_V_NEW        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_V_NEW        to CP_ROLE;
grant SELECT                                                                 on CP_V_NEW        to START1;
grant SELECT                                                                 on CP_V_NEW        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_NEW.sql =========*** End *** =====
PROMPT ===================================================================================== 
