 CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF17 
 as SELECT a.acc,
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
             CHK,
             'set role bars_access_defrole@KWT_2924.DEL_ATM3('
          || a.acc
          || ',:REF);'
		     CHK3,
            (SELECT s / 100
             FROM ATM_REF3
            WHERE ref1 = r1.REF1 AND acc = a.acc)
             S3,
          TO_NUMBER (pul.GET ('ITOG3')) / 100 ITOG3
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
		  
CREATE OR REPLACE SYNONYM BARS.V_ATMREF18 FOR BARS.V_ATMREF17;

GRANT SELECT ON BARS.V_ATMREF17 TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_ATMREF17 TO UPLD;
