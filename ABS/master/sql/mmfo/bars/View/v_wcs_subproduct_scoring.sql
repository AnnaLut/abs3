

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SCORING.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SUBPRODUCT_SCORING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SUBPRODUCT_SCORING ("SUBPRODUCT_ID", "SCORING_ID", "SCORING_NAME", "QUEST_CNT") AS 
  select ss.subproduct_id, ss.scoring_id, s.scoring_name, s.quest_cnt
  from wcs_subproduct_scoring ss, v_wcs_scorings s
 where ss.scoring_id = s.scoring_id;

PROMPT *** Create  grants  V_WCS_SUBPRODUCT_SCORING ***
grant SELECT                                                                 on V_WCS_SUBPRODUCT_SCORING to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SUBPRODUCT_SCORING.sql =========*
PROMPT ===================================================================================== 
