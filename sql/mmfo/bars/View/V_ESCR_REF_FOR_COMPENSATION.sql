create or replace view bars.V_ESCR_REF_FOR_COMPENSATION as
SELECT o.tt
      ,o.ref
      ,o.nlsb
      ,a.ostc
      ,o.nazn
      ,o.s
      ,a.acc
      ,substr(f_dop(o.ref, 'ND'), 1, 10) nd
      ,substr(f_dop(o.ref, 'DAT1'), 1, 10) sdate
      ,substr(f_dop(o.ref, 'CC_ID'), 1, 30) cc_id
      ,substr(f_dop(o.ref, 'IDB'), 1, 10) id_b
      ,(SELECT txt
          FROM opldok
         WHERE REF = o.ref
           AND rownum = 1) txt
  FROM oper o, nlk_ref r, accounts a
 WHERE a.tip = 'NLQ'
   AND a.acc = r.acc
   AND r.ref2 IS NULL
   AND r.ref1 = o.ref;
