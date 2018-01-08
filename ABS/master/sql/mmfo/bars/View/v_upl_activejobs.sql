

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UPL_ACTIVEJOBS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_ACTIVEJOBS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UPL_ACTIVEJOBS ("JOB_NAME", "DESCRIPT") AS 
  select "JOB_NAME","DESCRIPT" from barsupl.V_UPL_ACTIVEJOBS;

PROMPT *** Create  grants  V_UPL_ACTIVEJOBS ***
grant SELECT                                                                 on V_UPL_ACTIVEJOBS to BARSREADER_ROLE;
grant SELECT                                                                 on V_UPL_ACTIVEJOBS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UPL_ACTIVEJOBS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UPL_ACTIVEJOBS.sql =========*** End *
PROMPT ===================================================================================== 
