

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ZAG_PF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ZAG_PF ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ZAG_PF ("FN", "DAT", "N", "OTM", "DATK") AS 
  SELECT FN,
          DAT,
          N,
          OTM,
          DATK
     FROM ZAG_PF;

PROMPT *** Create  grants  V_ZAG_PF ***
grant SELECT                                                                 on V_ZAG_PF        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ZAG_PF        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_ZAG_PF        to DEB_REG;
grant SELECT                                                                 on V_ZAG_PF        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ZAG_PF.sql =========*** End *** =====
PROMPT ===================================================================================== 
