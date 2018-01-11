

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_QUESTIONS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_QUESTIONS ("ID", "NAME", "TYPE_ID", "TYPE_NAME", "IS_CALCABLE", "CALC_PROC") AS 
  select q.id,
       q.name,
       q.type_id,
       qt.name as type_name,
       q.is_calcable,
       q.calc_proc
  from wcs_questions q, wcs_question_types qt
 where q.type_id = qt.id;

PROMPT *** Create  grants  V_WCS_QUESTIONS ***
grant SELECT                                                                 on V_WCS_QUESTIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_QUESTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_QUESTIONS.sql =========*** End **
PROMPT ===================================================================================== 
