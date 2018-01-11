

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PSR.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view PSR ***

  CREATE OR REPLACE FORCE VIEW BARS.PSR ("NBS", "NAME") AS 
  (SELECT DISTINCT ps.nbs, ps.NAME
               FROM ps, accounts
              WHERE ps.nbs = SUBSTR (accounts.nbs, 1, 2) || '  ')
 ;

PROMPT *** Create  grants  PSR ***
grant SELECT                                                                 on PSR             to BARSREADER_ROLE;
grant SELECT                                                                 on PSR             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PSR             to START1;
grant SELECT                                                                 on PSR             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PSR             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PSR.sql =========*** End *** ==========
PROMPT ===================================================================================== 
