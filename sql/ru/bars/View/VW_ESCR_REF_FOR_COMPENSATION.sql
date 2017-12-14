CREATE OR REPLACE VIEW VW_ESCR_REF_FOR_COMPENSATION AS
SELECT o.tt,
       o.REF,
       o.nlsb,
       a.ostc,
       o.nazn,
       o.s,
       a.acc,
       SUBSTR(f_dop(o.REF, 'ND'), 1, 10) nd,
       SUBSTR(f_dop(o.REF, 'DAT1'), 1, 10) sdate,
       SUBSTR(f_dop(o.REF, 'CC_ID'), 1, 30) cc_id,
       SUBSTR(f_dop(o.REF, 'IDB'), 1, 10) id_b,
       (SELECT txt
          FROM opldok
         WHERE REF = o.REF
           AND ROWNUM = 1) txt
  FROM oper o, nlk_ref r, accounts a
 WHERE a.tip = 'NLQ'
   AND a.acc = r.acc
   AND r.ref2 IS NULL
   AND r.ref1 = o.REF;
grant select on VW_ESCR_REF_FOR_COMPENSATION to BARS_ACCESS_DEFROLE;
