

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/DEBREG_FILES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view DEBREG_FILES ***

  CREATE OR REPLACE FORCE VIEW BARS.DEBREG_FILES ("FN", "DAT", "N", "OTM", "DATK") AS 
  select fn, dat, n, otm, datk
from zag_pf;

PROMPT *** Create  grants  DEBREG_FILES ***
grant SELECT                                                                 on DEBREG_FILES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEBREG_FILES    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/DEBREG_FILES.sql =========*** End *** =
PROMPT ===================================================================================== 
