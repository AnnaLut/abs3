

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SURVEY_GROUPS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SURVEY_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SURVEY_GROUPS ("SURVEY_ID", "GROUP_ID", "GROUP_NAME", "DNSHOW_IF", "ORD", "RESULT_QID", "QUEST_CNT") AS 
  select sg.survey_id,
       sg.id as group_id,
       sg.name as group_name,
       sg.dnshow_if,
       sg.ord,
       sg.result_qid,
       (select count(*)
          from wcs_survey_group_questions sgq
         where sgq.survey_id = sg.survey_id
           and sgq.sgroup_id = sg.id
           and sgq.rectype_id = 'QUESTION') as quest_cnt
  from wcs_survey_groups sg
 order by sg.survey_id, sg.ord;

PROMPT *** Create  grants  V_WCS_SURVEY_GROUPS ***
grant SELECT                                                                 on V_WCS_SURVEY_GROUPS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SURVEY_GROUPS.sql =========*** En
PROMPT ===================================================================================== 
