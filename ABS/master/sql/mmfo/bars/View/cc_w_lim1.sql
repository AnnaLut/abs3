

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CC_W_LIM1.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CC_W_LIM1 ***

  CREATE OR REPLACE FORCE VIEW BARS.CC_W_LIM1 ("ND", "FDAT", "OTM", "NOT_9129", "LIM2", "SUMG", "SUMP", "SUMK", "SUMO", "SUMP1", "OST", "SUMO1", "SN") AS 
  SELECT nd, fdat, otm, NOT_9129, LIM2/100 LIM2, SUMG/100 SUMG, sump/100 SUMP, SUMK/100 SUMK,
       SUMO/100 SUMO, SUMP1/100 SUMP1, fOST_h(acc,fdat)/100 OST, (SUMO+sump1)/100 SUMO1, not_sn SN
FROM (SELECT acc, ND, FDAT, LIM2, NVL(SUMG,0) sumg, NVL(sumo,0)-NVL(sumg,0)-NVL(sumk,0) sump, NVL(SUMK,0) sumk, NVL(SUMO,0) sumo,
             NVL((SELECT sump1 FROM sno_GPP WHERE nd=L.ND AND fdat=l.FDAT),0) sump1, NVL(otm,0) otm, NVL(not_9129,0) not_9129, not_sn
      FROM cc_lim L  WHERE nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND'))
      )
;

PROMPT *** Create  grants  CC_W_LIM1 ***
grant SELECT                                                                 on CC_W_LIM1       to BARSREADER_ROLE;
grant SELECT                                                                 on CC_W_LIM1       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CC_W_LIM1.sql =========*** End *** ====
PROMPT ===================================================================================== 
