

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCANCOPY_QUESTIONS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCANCOPY_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCANCOPY_QUESTIONS ("SCOPY_ID", "QUESTION_ID", "QUESTION_NAME", "QUESTION_DESC", "TYPE_ID", "TYPE_NAME", "IS_REQUIRED", "ORD") AS 
  select sq.scopy_id,
       sq.question_id,
       q.name         as question_name,
       q.id || ' - ' || q.name as question_desc,
       sq.type_id,
       sqt.name       as type_name,
       sq.is_required,
       sq.ord
  from wcs_scancopy_questions      sq,
       wcs_questions               q,
       wcs_scancopy_question_types sqt
 where sq.question_id = q.id
   and sq.type_id = sqt.id
 order by sq.scopy_id, sq.ord;

PROMPT *** Create  grants  V_WCS_SCANCOPY_QUESTIONS ***
grant SELECT                                                                 on V_WCS_SCANCOPY_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCANCOPY_QUESTIONS.sql =========*
PROMPT ===================================================================================== 
