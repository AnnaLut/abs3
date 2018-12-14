create or replace view v_ob_corp_l1 as
select 
case when (select count(*) from ob_corporation w where w.parent_id = q.id) <> 0 then '++->' else null end as eh_ch,
CONNECT_BY_ROOT EXTERNAL_ID AS base_extid,
CONNECT_BY_ROOT CORPORATION_NAME AS base_name,
id,
corporation_name as corp_name, 
parent_id, 
case when state_id = 1 then 'Активний' 
     when state_id = 2 then 'Заблоковано' 
     when state_id = 3 then 'Закритий' 
     else 'Невідомий тип' end as state_id, 
to_number(external_id) as ext_id,
(select external_id from ob_corporation w where w.id = q.parent_id) as par_ext_id
from ob_corporation q
START WITH Q.PARENT_ID IS NULL
   CONNECT BY PRIOR id = parent_id;
/
grant SELECT on v_ob_corp_l1 to BARS_ACCESS_DEFROLE;
/
