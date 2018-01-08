

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ATMREF2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ATMREF2 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF2 ("NLS", "REF2", "VDAT2", "NLSA", "NLSB", "TT", "NAZN2", "S2", "ACC", "REF1") AS 
  select pul.GET('ATM_NLS') nls, o2.ref REF2, o2.vdat vdat2, o2.nlsa, o2.nlsb, o2.tt, o2.tt||'*'||o2.nazn NAZN2, o2.s/100 s2, to_number(pul.GET('ATM_ACC')) ACC, r2.REF1
  from oper o2, atm_ref2 r2 where o2.ref = r2.ref2   and r2.ref1 =  to_number(pul.GET('ATM_R1')) and o2.sos = 5 ;

PROMPT *** Create  grants  V_ATMREF2 ***
grant SELECT                                                                 on V_ATMREF2       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ATMREF2       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ATMREF2.sql =========*** End *** ====
PROMPT ===================================================================================== 
