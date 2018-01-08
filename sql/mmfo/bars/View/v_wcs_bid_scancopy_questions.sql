

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SCANCOPY_QUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_BID_SCANCOPY_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_BID_SCANCOPY_QUESTIONS ("BID_ID", "SCOPY_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "TYPE_NAME", "IS_REQUIRED") AS 
  select b.id           as bid_id,
       ss.scopy_id,
       sq.question_id,
       q.name         as question_name,
       sq.type_id,
       sqt.name       as type_name,
       sq.is_required
  from wcs_bids                    b,
       wcs_subproduct_scancopies   ss,
       wcs_scancopy_questions      sq,
       wcs_questions               q,
       wcs_scancopy_question_types sqt
 where b.subproduct_id = ss.subproduct_id
   and ss.scopy_id = sq.scopy_id
   and sq.question_id = q.id
   and sq.type_id = sqt.id
 order by b.id, ss.scopy_id, sq.ord;

PROMPT *** Create  grants  V_WCS_BID_SCANCOPY_QUESTIONS ***
grant SELECT                                                                 on V_WCS_BID_SCANCOPY_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_BID_SCANCOPY_QUESTIONS.sql ======
PROMPT ===================================================================================== 
