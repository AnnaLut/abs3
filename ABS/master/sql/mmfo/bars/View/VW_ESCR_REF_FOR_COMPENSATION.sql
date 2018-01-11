

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VW_ESCR_REF_FOR_COMPENSATION.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view VW_ESCR_REF_FOR_COMPENSATION ***

  CREATE OR REPLACE FORCE VIEW BARS.VW_ESCR_REF_FOR_COMPENSATION ("TT", "REF", "NLSB", "OSTC", "NAZN", "S", "ACC", "ND", "SDATE", "CC_ID", "ID_B", "TXT", "DATE_CHECK") AS 
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
           AND ROWNUM = 1) txt,
       case   when extract(month from o.vdat) =extract(month from gl.bd) then 0 else 1
       end date_check
  FROM oper o, nlk_ref r, accounts a
 WHERE a.tip = 'NLQ'
   AND a.acc = r.acc
   AND r.ref2 IS NULL
   AND r.ref1 = o.REF;

PROMPT *** Create  grants  VW_ESCR_REF_FOR_COMPENSATION ***
grant SELECT                                                                 on VW_ESCR_REF_FOR_COMPENSATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VW_ESCR_REF_FOR_COMPENSATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VW_ESCR_REF_FOR_COMPENSATION.sql ======
PROMPT ===================================================================================== 
