

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PSG.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view PSG ***

  CREATE OR REPLACE FORCE VIEW BARS.PSG ("NBS", "NAME") AS 
  SELECT DISTINCT ps.nbs, ps.NAME FROM ps, accounts
 WHERE ps.nbs = SUBSTR (accounts.nbs, 1, 3) || ' '
 ;

PROMPT *** Create  grants  PSG ***
grant SELECT                                                                 on PSG             to BARSREADER_ROLE;
grant SELECT                                                                 on PSG             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PSG             to START1;
grant SELECT                                                                 on PSG             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PSG.sql =========*** End *** ==========
PROMPT ===================================================================================== 
