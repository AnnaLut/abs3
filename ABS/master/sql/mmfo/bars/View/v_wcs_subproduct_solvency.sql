

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SOLVENCY.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_SOLVENCY ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_SOLVENCY ("SUBPRODUCT_ID", "SOLV_ID", "SOLV_NAME", "QUEST_CNT") AS 
  select ss.subproduct_id, ss.solv_id, s.solv_name, s.quest_cnt
  from wcs_subproduct_solvency ss, v_wcs_solvencies s
 where ss.solv_id = s.solv_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_SOLVENCY ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_SOLVENCY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SOLVENCY.sql =========
PROMPT ===================================================================================== 
