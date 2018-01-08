

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTPORTFOLIO_NBS888.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTPORTFOLIO_NBS888 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTPORTFOLIO_NBS888 ("NBS", "XAR", "PAP", "NAME", "CLASS", "CHKNBS", "AUTO_STOP", "D_CLOSE", "SB") AS 
  SELECT p."NBS",
          p."XAR",
          p."PAP",
          p."NAME",
          p."CLASS",
          p."CHKNBS",
          p."AUTO_STOP",
          p."D_CLOSE",
          p."SB"
     FROM ps p JOIN notportfolio_kd888 n ON p.nbs = n.nbs;

PROMPT *** Create  grants  V_NOTPORTFOLIO_NBS888 ***
grant SELECT                                                                 on V_NOTPORTFOLIO_NBS888 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTPORTFOLIO_NBS888.sql =========*** 
PROMPT ===================================================================================== 
