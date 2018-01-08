

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/KLPEOM.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view KLPEOM ***

  CREATE OR REPLACE FORCE VIEW BARS.KLPEOM ("EOM", "KWO", "SUMMA") AS 
  select eom,count(*) kwo,sum(s)/100 summa from klp where fl<3 group by eom 
 ;

PROMPT *** Create  grants  KLPEOM ***
grant SELECT                                                                 on KLPEOM          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLPEOM          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPEOM          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/KLPEOM.sql =========*** End *** =======
PROMPT ===================================================================================== 
