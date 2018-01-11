

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SURVEY_GROUP_QUESTIONS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SURVEY_GROUP_QUESTIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SURVEY_GROUP_QUESTIONS ("SURVEY_ID", "GROUP_ID", "RECTYPE_ID", "QUESTION_ID", "QUESTION_NAME", "TYPE_ID", "TYPE_NAME", "DNSHOW_IF", "IS_REQUIRED", "IS_READONLY", "IS_REWRITABLE", "IS_CHECKABLE", "CHECK_PROC", "ORD") AS 
  select sgq.survey_id,
       sgq.sgroup_id     as group_id,
       sgq.rectype_id,
       sgq.question_id,
       q.name            as question_name,
       q.type_id,
       qt.name           as type_name,
       sgq.dnshow_if,
       sgq.is_required,
       sgq.is_readonly,
       sgq.is_rewritable,
       sgq.is_checkable,
       sgq.check_proc,
       sgq.ord
  from wcs_survey_group_questions sgq,
       wcs_questions              q,
       wcs_question_types         qt
 where sgq.question_id = q.id
   and q.type_id = qt.id
 order by sgq.survey_id, sgq.sgroup_id, sgq.ord;

PROMPT *** Create  grants  V_WCS_SURVEY_GROUP_QUESTIONS ***
grant SELECT                                                                 on V_WCS_SURVEY_GROUP_QUESTIONS to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SURVEY_GROUP_QUESTIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SURVEY_GROUP_QUESTIONS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SURVEY_GROUP_QUESTIONS.sql ======
PROMPT ===================================================================================== 
