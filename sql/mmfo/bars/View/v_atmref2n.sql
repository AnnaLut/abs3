

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ATMREF2N.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ATMREF2N ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF2N ("ACC", "DK1", "FDAT1", "REF1", "S1", "DK2", "FDAT2", "REF2", "S2", "NLSK", "NAZN2") AS 
  SELECT p1.ACC, p1.DK DK1,  p1.FDAT FDAT1,  p1.REF REF1,  p1.s/100 s1,           p2.DK DK2,  p2.FDAT FDAT2,  p2.REF REF2,  p2.s/100 s2,
         pul.GET ('ATM_NLS') || '-->' || DECODE (pul.GET ('ATM_NLS'), o2.nlsa, o2.nlsb, o2.nlsa) nlsK,        o2.tt || '*' || o2.nazn NAZN2
   FROM oper o2, opldok p2,
       (SELECT * FROM opldok WHERe REF = TO_NUMBER(pul.GET('ATM_R1')) and acc= TO_NUMBER(pul.GET('ATM_ACC')) and dk= TO_NUMBER(pul.GET('ATM_DK')) AND ROWNUM=1 AND sos=5 ) p1
   WHERE o2.REF= p2.REF AND p2.sos= 5  AND p2.acc= p1.acc  AND p2.dk = 1 - p1.dk  AND p2.fdat >= p1.fdat   and p2.s <= p1.s  AND NOT EXISTS   (SELECT 1  FROM atm_ref2   WHERE ref2 = o2.REF);

PROMPT *** Create  grants  V_ATMREF2N ***
grant SELECT                                                                 on V_ATMREF2N      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ATMREF2N      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ATMREF2N.sql =========*** End *** ===
PROMPT ===================================================================================== 
