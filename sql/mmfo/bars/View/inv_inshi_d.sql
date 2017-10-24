

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/INV_INSHI_D.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view INV_INSHI_D ***

  CREATE OR REPLACE FORCE VIEW BARS.INV_INSHI_D ("G00", "G01", "G02", "G03", "G04", "G07", "G19", "G20", "G21", "G22", "G28", "G30", "ACC", "RNK", "NLS") AS 
  (select G00, G01 , G02 , G03 , G04 , G07 , G19 , G20 , G21 , G22 , G28 , G30 , i.ACC, i.RNK, a.nls from INV_FL i, accounts a where GR = 'I' and i.acc = a.acc);

PROMPT *** Create  grants  INV_INSHI_D ***
grant SELECT,UPDATE                                                          on INV_INSHI_D     to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on INV_INSHI_D     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/INV_INSHI_D.sql =========*** End *** ==
PROMPT ===================================================================================== 
