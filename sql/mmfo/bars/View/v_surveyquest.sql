

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SURVEYQUEST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SURVEYQUEST ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SURVEYQUEST ("SURVEY_ID", "SURVEY_NAME", "SURVEY_TEMPLATE", "GRP_ID", "GRP_NUMBER", "GRP_NAME", "GRP_ORD", "QUEST_ID", "QUEST_NAME", "QUEST_ORD", "FMT_ID", "FMT_NAME", "LIST_ID", "QUEST_MULTI", "QUEST_STATE", "FL_PARENT") AS 
  SELECT s.survey_id, s.survey_name, s.template_id,
       g.grp_id, g.grp_number, g.grp_name, g.grp_ord,
       q.quest_id, q.quest_name, q.quest_ord,
       f.fmt_id, f.fmt_name,
       q.list_id, q.quest_multi,
       nvl(dc.child_state,1),
       decode(count(dp.child_id), 0, 0, 1)
  FROM survey s, survey_qgrp g, survey_qfmt f, survey_quest q,
       survey_quest_dep dp, survey_quest_dep dc
 WHERE s.activity = 1
   AND s.survey_id = g.survey_id
   AND s.survey_id = q.survey_id
   AND q.qgrp_id = g.grp_id
   AND f.fmt_id = q.qfmt_id
   AND q.quest_id = dp.quest_id(+)
   AND q.quest_id = dc.child_id(+)
 GROUP BY s.survey_id, s.survey_name, s.template_id,
       g.grp_id, g.grp_number, g.grp_name, g.grp_ord,
       q.quest_id, q.quest_name, q.quest_ord,
       f.fmt_id, f.fmt_name,
       q.list_id, q.quest_multi, dc.child_state
 ORDER BY s.survey_id, g.grp_ord, q.quest_ord
 ;

PROMPT *** Create  grants  V_SURVEYQUEST ***
grant SELECT                                                                 on V_SURVEYQUEST   to BARSREADER_ROLE;
grant SELECT                                                                 on V_SURVEYQUEST   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SURVEYQUEST   to DPT_ROLE;
grant SELECT                                                                 on V_SURVEYQUEST   to SUR_ROLE;
grant SELECT                                                                 on V_SURVEYQUEST   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SURVEYQUEST   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SURVEYQUEST.sql =========*** End *** 
PROMPT ===================================================================================== 
