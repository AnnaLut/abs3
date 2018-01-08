

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_WCS_SCORINGS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_WCS_SCORINGS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_WCS_SCORINGS ("SCORING_ID", "SCORING_NAME", "QUEST_CNT", "RESULT_QID") AS 
  select s.id as scoring_id,
       s.name as scoring_name,
       (select count(*)
          from wcs_scoring_questions sq
         where sq.scoring_id = s.id) as quest_cnt,
       s.result_qid
  from wcs_scorings s
 order by s.id;

PROMPT *** Create  grants  V_WCS_SCORINGS ***
grant SELECT                                                                 on V_WCS_SCORINGS  to BARSREADER_ROLE;
grant SELECT                                                                 on V_WCS_SCORINGS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_WCS_SCORINGS  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_WCS_SCORINGS.sql =========*** End ***
PROMPT ===================================================================================== 
