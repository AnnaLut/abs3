

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PSK.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** Create  view PSK ***

  CREATE OR REPLACE FORCE VIEW BARS.PSK ("NBS", "NAME") AS 
  (SELECT DISTINCT p.nbs, p.NAME
               FROM ps p, accounts a
              WHERE p.nbs = SUBSTR (a.nbs, 1, 1) || '   ')
 ;

PROMPT *** Create  grants  PSK ***
grant SELECT                                                                 on PSK             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PSK             to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PSK             to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PSK.sql =========*** End *** ==========
PROMPT ===================================================================================== 
