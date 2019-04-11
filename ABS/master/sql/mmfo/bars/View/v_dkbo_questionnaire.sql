create or replace view v_dkbo_questionnaire as
select *
from (select case when a.attribute_code like '%ADDITIONAL%' then 1 /*else null end as questionnaire_group*/
                  when a.attribute_code like '%HIST%' then 2
                  else null
             end as quest_group_id,
             case when a.attribute_code like '%ADDITIONAL%' then 'Додаткова інформація' /*else null end as questionnaire_group*/
                  when a.attribute_code like '%HIST%' then 'Кредитна історія'
                  else null
             end as quest_group,
             a.attribute_code quest_code,
             a.attribute_name quest_name,
             list_utl.get_item_code('ATTRIBUTE_VALUE_TYPE', a.value_type_id) quest_type,
             lt.list_code,
             lt.list_name,
             lt.id list_id
      from attribute_kind a
      left join list_type lt on lt.id = a.list_type_id and
                                lt.is_active = 'Y'
      where a.object_type_id = (select o.id from object_type o where o.type_code = 'DKBO') and
            a.state_id = 2 /*attribtue_utl.ATTR_STATE_ACTIVE*/) t
where t.quest_group is not null
order by t.quest_group_id,t.quest_code;

grant SELECT                                                                 on V_DKBO_QUESTIONNAIRE to BARSREADER_ROLE;
grant SELECT                                                                 on V_DKBO_QUESTIONNAIRE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DKBO_QUESTIONNAIRE to UPLD;

