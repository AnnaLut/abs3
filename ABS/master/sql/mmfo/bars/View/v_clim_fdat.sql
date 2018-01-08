

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CLIM_FDAT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CLIM_FDAT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CLIM_FDAT ("FDAT") AS 
  select fdat
from fdat
where fdat < bankdate
   and fdat >= clim_ru_pack.get_startdate;

PROMPT *** Create  grants  V_CLIM_FDAT ***
grant SELECT                                                                 on V_CLIM_FDAT     to BARSREADER_ROLE;
grant SELECT                                                                 on V_CLIM_FDAT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CLIM_FDAT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CLIM_FDAT.sql =========*** End *** ==
PROMPT ===================================================================================== 
