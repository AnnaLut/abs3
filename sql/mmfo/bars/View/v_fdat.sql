

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FDAT.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FDAT ("FDAT", "STATUS") AS 
  select fdat, case when stat is null then 0 when stat=9 then 1 else stat end status from fdat
order by fdat desc;

PROMPT *** Create  grants  V_FDAT ***
grant SELECT,UPDATE                                                          on V_FDAT          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FDAT.sql =========*** End *** =======
PROMPT ===================================================================================== 
