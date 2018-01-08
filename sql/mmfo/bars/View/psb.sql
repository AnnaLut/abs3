

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PSB.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view PSB ***

  CREATE OR REPLACE FORCE VIEW BARS.PSB ("NBS", "NAME") AS 
  SELECT DISTINCT ps.nbs, ps.NAME FROM ps, accounts WHERE ps.nbs = accounts.nbs
 ;

PROMPT *** Create  grants  PSB ***
grant SELECT                                                                 on PSB             to BARSREADER_ROLE;
grant SELECT                                                                 on PSB             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PSB             to START1;
grant SELECT                                                                 on PSB             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PSB.sql =========*** End *** ==========
PROMPT ===================================================================================== 
