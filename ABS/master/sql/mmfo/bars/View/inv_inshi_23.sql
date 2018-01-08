

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/INV_INSHI_23.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view INV_INSHI_23 ***

  CREATE OR REPLACE FORCE VIEW BARS.INV_INSHI_23 ("G00", "G01", "G02", "G03", "G04", "G07", "G19", "G20", "G21", "G22", "G25", "G29", "G30", "ACC", "RNK", "NLS") AS 
  (select G00, G01 , G02 , G03 , G04 , G07 , G19 , G20 , G21 , G22 , G25 , G29 , G30 , i.ACC, i.RNK, a.nls from INV_FL_23 i, accounts a where GR = 'I' and i.acc = a.acc);

PROMPT *** Create  grants  INV_INSHI_23 ***
grant SELECT                                                                 on INV_INSHI_23    to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on INV_INSHI_23    to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on INV_INSHI_23    to RCC_DEAL;
grant SELECT                                                                 on INV_INSHI_23    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/INV_INSHI_23.sql =========*** End *** =
PROMPT ===================================================================================== 
