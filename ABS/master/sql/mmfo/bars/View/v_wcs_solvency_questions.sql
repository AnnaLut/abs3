

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SOLVENCY_QUESTIONS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SOLVENCY_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SOLVENCY_QUESTIONS ("SOLVENCY_ID", "QUESTION_ID", "QUESTION_NAME", "QUESTION_DESC", "TYPE_ID", "TYPE_NAME", "CALC_PROC") AS 
  select sq.solvency_id,
       sq.question_id,
       q.name         as question_name,
       q.id || ' - ' || q.name as question_desc,
       q.type_id,
       qt.name        as type_name,
       q.calc_proc
  from wcs_solvency_questions sq, wcs_questions q, wcs_question_types qt
 where sq.question_id = q.id
   and q.type_id = qt.id
 order by sq.solvency_id, sq.question_id;

PROMPT *** Create  grants  V_WCS_SOLVENCY_QUESTIONS ***
grant SELECT                                                                 on V_WCS_SOLVENCY_QUESTIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SOLVENCY_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SOLVENCY_QUESTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SOLVENCY_QUESTIONS.sql =========*
PROMPT ===================================================================================== 
