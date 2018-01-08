

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_UPL_GROUPS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_UPL_GROUPS ("GROUP_ID", "DESCRIPT") AS 
  select "GROUP_ID","DESCRIPT" from barsupl.upl_groups;

PROMPT *** Create  grants  V_UPL_GROUPS ***
grant SELECT                                                                 on V_UPL_GROUPS    to BARSREADER_ROLE;
grant SELECT                                                                 on V_UPL_GROUPS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_UPL_GROUPS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_UPL_GROUPS.sql =========*** End *** =
PROMPT ===================================================================================== 
