create or replace view v_reckoning_group_mode as
select li.list_item_id id, li.list_item_code code, li.list_item_name name
from   list_item li
join   list_type lt on lt.id = li.list_type_id
where  lt.list_code = 'RECKONING_GROUPING_MODE' and
       li.is_active = 'Y';
