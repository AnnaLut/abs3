

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SURVEYANSWER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SURVEYANSWER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SURVEYANSWER ("SURVEY_ID", "GRP_ID", "GRP_ORD", "QUEST_ID", "QUEST_NAME", "QUEST_ORD", "QUEST_MULTI", "ANSWER_KEY", "ANSWER_VALUE", "ANSWER_ORD", "ANSWER_DEFAULT", "ANSWER_TYPE") AS 
  SELECT q.survey_id, q.qgrp_id, g.grp_ord,
       q.quest_id, q.quest_name, q.quest_ord, q.quest_multi,
       o.opt_id, o.opt_val, o.opt_ord, o.opt_dflt, '_'
  FROM survey_quest q, survey_answer_opt o, survey_qgrp g
 WHERE q.qfmt_id = 1  /* выбор варианта ответа */
   AND q.list_id = o.list_id
   AND q.qgrp_id = g.grp_id
 UNION ALL
SELECT q.survey_id, q.qgrp_id, g.grp_ord,
       q.quest_id, q.quest_name, q.quest_ord, q.quest_multi,
       x.id, x.name, rownum, 0, '_'
  FROM survey_quest q, survey_qgrp g,
       TABLE(cust_survey.read_extrnl_tbl(q.extrn_tabname,q.extrn_tabkey,q.extrn_tabvalue)) x
 WHERE q.qfmt_id = 2 /* выбор из базового справочника */
   AND q.qgrp_id = g.grp_id
 UNION ALL
SELECT q.survey_id, q.qgrp_id, g.grp_ord,
       q.quest_id, q.quest_name, q.quest_ord, q.quest_multi,
       null, null, 1, 0, decode (qfmt_id, '3', 'S', 4, 'N', 'D')
  FROM survey_quest q, survey_qgrp g
 WHERE q.qfmt_id IN (3, 4, 5) /* свободный ответ */
   AND q.qgrp_id = g.grp_id
 ORDER BY 1, 3, 5, 7
 ;

PROMPT *** Create  grants  V_SURVEYANSWER ***
grant SELECT                                                                 on V_SURVEYANSWER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SURVEYANSWER  to DPT_ROLE;
grant SELECT                                                                 on V_SURVEYANSWER  to SUR_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SURVEYANSWER  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SURVEYANSWER.sql =========*** End ***
PROMPT ===================================================================================== 
