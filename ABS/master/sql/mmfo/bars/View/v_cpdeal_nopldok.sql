

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CPDEAL_NOPLDOK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CPDEAL_NOPLDOK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CPDEAL_NOPLDOK ("CP_REF", "REF", "TT", "DK", "ACC", "FDAT", "S_INT", "SQ_INT", "S_PAY", "SQ_PAY", "TXT") AS 
  SELECT cd.ref,
       o.REF,
       TT,
       DK,
       o.ACC,
       FDAT,
       case when DK = 0 then S/100      else 0 end as S_INT,
       case when DK = 0 then SQ/100     else 0 end as S_INT,
       case when DK = 0 then 0          else S/100 end as S_PAY,
       case when DK = 0 then 0          else SQ/100 end as S_PAY,
       TXT
  FROM opldok o, cp_deal cd
 WHERE     o.sos = 5
       AND CD.ACC = o.acc
       AND o.fdat BETWEEN CD.DAT_UG AND NVL (cd.dazs, bankdate);

PROMPT *** Create  grants  V_CPDEAL_NOPLDOK ***
grant SELECT                                                                 on V_CPDEAL_NOPLDOK to BARSREADER_ROLE;
grant SELECT                                                                 on V_CPDEAL_NOPLDOK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CPDEAL_NOPLDOK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CPDEAL_NOPLDOK.sql =========*** End *
PROMPT ===================================================================================== 
