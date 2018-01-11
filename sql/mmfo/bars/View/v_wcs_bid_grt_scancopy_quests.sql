

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_SCANCOPY_QUESTS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_GRT_SCANCOPY_QUESTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_GRT_SCANCOPY_QUESTS ("BID_ID", "GARANTEE_ID", "GARANTEE_NUM", "SCOPY_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "TYPE_NAME", "IS_REQUIRED") AS 
  select bg.bid_id,
       bg.garantee_id,
       bg.garantee_num,
       sq.scopy_id,
       sq.question_id,
       q.name          as question_name,
       sq.type_id,
       sqt.name        as type_name,
       sq.is_required
  from v_wcs_bid_garantees         bg,
       wcs_garantees               g,
       wcs_scancopy_questions      sq,
       wcs_questions               q,
       wcs_scancopy_question_types sqt
 where bg.garantee_id = g.id
   and g.scopy_id = sq.scopy_id
   and sq.question_id = q.id
   and sq.type_id = sqt.id
 order by bg.bid_id, bg.garantee_id, bg.garantee_num, sq.scopy_id, sq.ord;

PROMPT *** Create  grants  V_WCS_BID_GRT_SCANCOPY_QUESTS ***
grant SELECT                                                                 on V_WCS_BID_GRT_SCANCOPY_QUESTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_BID_GRT_SCANCOPY_QUESTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_BID_GRT_SCANCOPY_QUESTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_GRT_SCANCOPY_QUESTS.sql =====
PROMPT ===================================================================================== 
