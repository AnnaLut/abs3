

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ATMREF17.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ATMREF17 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF17 ("ACC", "KV", "NLS", "NMS", "BRANCH", "TIP", "OB22", "OSTC", "DK", "REF1", "VDAT1", "S1", "NAZN1", "KOL", "S2", "DEL", "NLS_2909", "NAZN_PKR", "NAZN_015", "NAZN_310", "CHK") AS 
  SELECT a.acc,
          a.kv,
          a.nls,
          a.nms,
          a.branch,
          a.tip,
          a.ob22,
          a.ostc / 100 OSTC,
          a.pap - 1 DK,
          r1.REF1,
          o1.vdat vdat1,
          o1.s / 100 s1,
          o1.tt || '*' || o1.nazn nazn1,
          NVL (r2.KOL, 0) kol,
          NVL (r2.S / 100, 0) S2,
          (o1.S - NVL (r2.s, 0)) / 100 DEL,
          nbs_ob22_bra ('2909', '81', a.branch) nls_2909,
             'Зараховано на карт/рах. зг. звернення SC-...(надл. за '
          || TO_CHAR (o1.vdat, 'dd/mm/yyyy')
          || ',реф.'
          || r1.REF1
          || ','
          || a.NMS
          || ')'
             NAZN_PKR,
             'Кошти для виплати <ПІБ> зг. звернення SC-...(надл. за '
          || TO_CHAR (o1.vdat, 'dd/mm/yyyy')
          || ',реф.'
          || r1.REF1
          || ','
          || a.NMS
          || ')'
             NAZN_015,
             'Кошти для зарах на рах.2625 ПІБ, ІНН; SC-...(надл. за '
          || TO_CHAR (o1.vdat, 'dd/mm/yyyy')
          || ',реф.'
          || r1.REF1
          || ','
          || a.NMS
          || ')'
             NAZN_310,
             'set role bars_access_defrole@KWT_2924.INS_ATM2('
          || a.acc
          || ','
          || r1.ref1
          || ',:REF);'
             CHK
     FROM (SELECT *
             FROM accounts
            WHERE acc = TO_NUMBER (pul.GET ('ATM_ACC'))) a,
          (SELECT *
             FROM atm_ref1
            WHERE acc = TO_NUMBER (pul.GET ('ATM_ACC'))) r1,
          oper o1,
          (  SELECT r.ref1, COUNT (*) kol, SUM (o.s) s
               FROM atm_ref2 r, oper o
              WHERE o.REF = r.ref2 AND o.sos = 5
           GROUP BY r.ref1) r2
    WHERE     a.acc = r1.acc
          AND r1.ref1 = o1.REF
          AND r1.ref1 = r2.ref1(+)
          AND o1.sos = 5;

PROMPT *** Create  grants  V_ATMREF17 ***
grant SELECT                                                                 on V_ATMREF17      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ATMREF17      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ATMREF17.sql =========*** End *** ===
PROMPT ===================================================================================== 
