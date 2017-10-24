

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/LOM_234.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view LOM_234 ***

  CREATE OR REPLACE FORCE VIEW BARS.LOM_234 ("NPP", "NAZN", "SUM1", "SUM2") AS 
  SELECT id, nazn, s, s  FROM lom_nazn   where id in (2,3,4);

PROMPT *** Create  grants  LOM_234 ***
grant FLASHBACK,SELECT,UPDATE                                                on LOM_234         to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on LOM_234         to RCC_DEAL;
grant FLASHBACK,SELECT,UPDATE                                                on LOM_234         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/LOM_234.sql =========*** End *** ======
PROMPT ===================================================================================== 
