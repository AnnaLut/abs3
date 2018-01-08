

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DKBO_QUESTIONNAIRE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DKBO_QUESTIONNAIRE ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DKBO_QUESTIONNAIRE ("QUEST_GROUP_ID", "QUEST_GROUP", "QUEST_CODE", "QUEST_NAME", "QUEST_TYPE", "LIST_CODE", "LIST_NAME", "LIST_ID") AS 
  select "QUEST_GROUP_ID","QUEST_GROUP","QUEST_CODE","QUEST_NAME","QUEST_TYPE","LIST_CODE","LIST_NAME","LIST_ID"   from (
SELECT
    CASE
         WHEN a.attribute_code LIKE '%ADDITIONAL%' THEN
          1 /*else null end as QUESTIONNAIRE_GROUP*/
         WHEN a.attribute_code LIKE '%HIST%' THEN
          2
         ELSE
          NULL
       END AS quest_group_id
      ,CASE
         WHEN a.attribute_code LIKE '%ADDITIONAL%' THEN
          'Додаткова інформація' /*else null end as QUESTIONNAIRE_GROUP*/
         WHEN a.attribute_code LIKE '%HIST%' THEN
          'Кредитна історія'
         ELSE
          NULL
       END AS quest_group
      ,a.attribute_code quest_code
      ,a.attribute_name quest_name
      ,CASE a.value_type_id
         WHEN 1 THEN
          'NUMBER'
         WHEN 2 THEN
          'STRING'
         WHEN 3 THEN
          'DATE'
         WHEN 4 THEN
          'CLOB'
         WHEN 5 THEN
          'BLOB'
         WHEN 6 THEN
          'LIST'
         ELSE
          NULL
       END AS quest_type
      ,lt.list_code list_code
      ,lt.list_name list_name
      ,lt.id list_id
  FROM attribute_kind a
  JOIN object_type o
    ON o.id = a.object_type_id
   AND o.type_code = 'DKBO'
   And a.state_id IN(select li.list_item_id from list_item li,list_type lt  where li.list_item_code='ACTIVE' and li.list_type_id=lt.id)
  LEFT JOIN list_type lt
    ON lt.id = a.list_type_id  and lt.is_active='Y') t where t.quest_group is not null
    order by t.quest_group_id,t.quest_code;

PROMPT *** Create  grants  V_DKBO_QUESTIONNAIRE ***
grant SELECT                                                                 on V_DKBO_QUESTIONNAIRE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DKBO_QUESTIONNAIRE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DKBO_QUESTIONNAIRE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DKBO_QUESTIONNAIRE.sql =========*** E
PROMPT ===================================================================================== 
