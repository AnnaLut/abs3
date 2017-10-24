

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_ACTIVEJOBS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_ACTIVEJOBS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_ACTIVEJOBS ("JOB_NAME", "DESCRIPT") AS 
  select job_name, descript
from upl_autojobs where is_active =1;

PROMPT *** Create  grants  V_UPL_ACTIVEJOBS ***
grant SELECT                                                                 on V_UPL_ACTIVEJOBS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UPL_ACTIVEJOBS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_ACTIVEJOBS.sql =========*** En
PROMPT ===================================================================================== 
