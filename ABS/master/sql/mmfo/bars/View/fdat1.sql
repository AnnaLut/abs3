

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FDAT1.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view FDAT1 ***

  CREATE OR REPLACE FORCE VIEW BARS.FDAT1 ("FDAT") AS 
  select distinct fdat from saldoa

 ;

PROMPT *** Create  grants  FDAT1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FDAT1           to ABS_ADMIN;
grant SELECT                                                                 on FDAT1           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FDAT1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FDAT1           to START1;
grant SELECT                                                                 on FDAT1           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FDAT1           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FDAT1.sql =========*** End *** ========
PROMPT ===================================================================================== 
