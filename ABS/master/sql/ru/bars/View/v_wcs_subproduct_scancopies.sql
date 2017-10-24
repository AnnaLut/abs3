

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SCANCOPIES.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_SCANCOPIES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_SCANCOPIES ("SUBPRODUCT_ID", "SCOPY_ID", "SCOPY_NAME", "QUEST_CNT") AS 
  select ss.subproduct_id, ss.scopy_id, s.scopy_name, s.quest_cnt
  from wcs_subproduct_scancopies ss, v_wcs_scancopies s
 where ss.scopy_id = s.scopy_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_SCANCOPIES ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_SCANCOPIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SCANCOPIES.sql =======
PROMPT ===================================================================================== 
