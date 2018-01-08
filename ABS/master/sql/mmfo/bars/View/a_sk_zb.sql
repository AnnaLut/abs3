

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/A_SK_ZB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view A_SK_ZB ***

  CREATE OR REPLACE FORCE VIEW BARS.A_SK_ZB ("KOD", "NAME") AS 
  SELECT sk, NAME
     FROM sk
    WHERE sk > 75 AND sk <= 99
 ;

PROMPT *** Create  grants  A_SK_ZB ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on A_SK_ZB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/A_SK_ZB.sql =========*** End *** ======
PROMPT ===================================================================================== 
