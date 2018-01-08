

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ESCR_REF_FOR_COMPENSATION.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ESCR_REF_FOR_COMPENSATION ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ESCR_REF_FOR_COMPENSATION ("TT", "REF", "NLSB", "OSTC", "NAZN", "S", "ACC", "ND", "SDATE", "CC_ID", "ID_B", "TXT") AS 
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

PROMPT *** Create  grants  V_ESCR_REF_FOR_COMPENSATION ***
grant SELECT                                                                 on V_ESCR_REF_FOR_COMPENSATION to BARSREADER_ROLE;
grant SELECT                                                                 on V_ESCR_REF_FOR_COMPENSATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ESCR_REF_FOR_COMPENSATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ESCR_REF_FOR_COMPENSATION.sql =======
PROMPT ===================================================================================== 
