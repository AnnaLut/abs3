

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_AUTHORIZATION_QUESTIONS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_AUTHORIZATION_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_AUTHORIZATION_QUESTIONS ("AUTH_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "TYPE_NAME", "SCOPY_QID", "IS_REQUIRED", "IS_CHECKABLE", "CHECK_PROC", "ORD") AS 
  select aq.auth_id,
       aq.question_id,
       q.name          as question_name,
       q.type_id,
       qt.name         as type_name,
       aq.scopy_qid,
       aq.is_required,
       aq.is_checkable,
       aq.check_proc,
       aq.ord
  from wcs_authorization_questions aq,
       wcs_questions               q,
       wcs_question_types          qt
 where aq.question_id = q.id
   and q.type_id = qt.id;

PROMPT *** Create  grants  V_WCS_AUTHORIZATION_QUESTIONS ***
grant SELECT                                                                 on V_WCS_AUTHORIZATION_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_AUTHORIZATION_QUESTIONS.sql =====
PROMPT ===================================================================================== 
