

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CPDEAL_ROPLDOK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CPDEAL_ROPLDOK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CPDEAL_ROPLDOK ("CP_REF", "REF", "TT", "DK", "ACC", "FDAT", "S_INT", "SQ_INT", "S_PAY", "SQ_PAY", "TXT") AS 
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
       AND CD.ACCR = o.acc
       AND o.fdat BETWEEN CD.DAT_UG AND NVL (cd.dazs, bankdate);

PROMPT *** Create  grants  V_CPDEAL_ROPLDOK ***
grant SELECT                                                                 on V_CPDEAL_ROPLDOK to BARSREADER_ROLE;
grant SELECT                                                                 on V_CPDEAL_ROPLDOK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CPDEAL_ROPLDOK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CPDEAL_ROPLDOK.sql =========*** End *
PROMPT ===================================================================================== 
