

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_INFOQUERY_QUESTIONS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_INFOQUERY_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_INFOQUERY_QUESTIONS ("IQUERY_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "TYPE_NAME", "IS_REQUIRED", "IS_CHECKABLE", "CHECK_PROC", "ORD") AS 
  select iq.iquery_id,
       iq.question_id,
       q.name         as question_name,
       q.type_id,
       qt.name        as type_name,
       iq.is_required,
       iq.is_checkable,
       iq.check_proc,
       iq.ord
  from wcs_infoquery_questions iq, wcs_questions q, wcs_question_types qt
 where iq.question_id = q.id
   and q.type_id = qt.id
 order by iq.ord;

PROMPT *** Create  grants  V_WCS_INFOQUERY_QUESTIONS ***
grant SELECT                                                                 on V_WCS_INFOQUERY_QUESTIONS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_INFOQUERY_QUESTIONS.sql =========
PROMPT ===================================================================================== 
