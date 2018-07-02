
--17.04.2018

CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF17 AS
SELECT a.acc, a.kv, a.nls, a.nms, a.branch, a.tip, a.ob22, a.ostc/100 OSTC, a.pap-1 DK, r1.REF1, o1.vdat vdat1, o1.s/100 s1, 
       o1.tt||'*'||o1.nazn nazn1,
       NVL(r2.KOL,0)         kol, 
       NVL(r2.S/100,0)        S2,
       (o1.S-NVL(r2.s,0))/100 DEL,
       NVL(nbs_ob22_bra('2909','81',a.branch), '2909/81') nls_2909, -- д.б. открыт для редактирования
       KWT_2924.NAZN7 (a.acc, r1.REF1, 'PKR', 1, a.nms)   NAZN_PKR, -- Зараховано на карт/рах. зг. звернення SC-...(надл. за '||to_char (o1.vdat, 'dd/mm/yyyy') || ',реф.'|| r1.REF1||','|| a.NMS||')'
       KWT_2924.NAZN7 (a.acc, r1.REF1, '015', 1, a.nms)   NAZN_015, -- Кошти для виплати <ПІБ> зг. звернення SC-...(надл. за '||to_char (o1.vdat, 'dd/mm/yyyy') || ',реф.'|| r1.REF1||','|| a.NMS||')'
       KWT_2924.NAZN7 (a.acc, r1.REF1, '310', 1, a.nms)   NAZN_310, -- Кошти для зарах на рах.2625 ПІБ, ІНН; SC-...(надл. за '||to_char (o1.vdat, 'dd/mm/yyyy') || ',реф.'|| r1.REF1||','|| a.NMS||')' NAZN_310,
       KWT_2924.NAZN7 (a.acc, r1.REF1, '013', 1, a.nms)   NAZX1,
       KWT_2924.NAZN7 (a.acc, r1.REF1, '013', 2, a.nms)   NAZX2,
       KWT_2924.NAZN7 (a.acc, r1.REF1, '013', 3, a.nms)   NAZX3,
      'set role bars_access_defrole@KWT_2924.INS_ATM2('|| a.acc||','||r1.ref1||',null);'  CHK,
      'set role bars_access_defrole@KWT_2924.INS_ATM2('|| a.acc||',      0      ,null);' CHK3,
      (SELECT s/100  FROM ATM_REF3   WHERE ref1 = r1.REF1 AND acc = a.acc)                S3,
      TO_NUMBER(pul.GET('ITOG3'))/100                                                     ITOG3 
FROM (SELECT *  FROM accounts WHERE acc = TO_NUMBER (pul.GET ('ATM_ACC'))) a,
     (SELECT *  FROM atm_ref1 WHERE acc = TO_NUMBER (pul.GET ('ATM_ACC'))) r1,       oper o1,
     (SELECT r.ref1, COUNT(*) kol, SUM(NVL(r.S,o.s)) s FROM atm_ref2 r, oper o WHERE o.REF=r.ref2 AND o.sos=5 GROUP BY r.ref1) r2
WHERE a.acc = r1.acc   AND r1.ref1 = o1.REF   AND r1.ref1 = r2.ref1(+)    AND o1.sos = 5;


CREATE OR REPLACE SYNONYM BARS.V_ATMREF18 FOR BARS.V_ATMREF17;
grant select  on bars.v_atmref17  TO BARS_ACCESS_DEFROLE;
grant select  on bars.v_atmref18  TO BARS_ACCESS_DEFROLE;

