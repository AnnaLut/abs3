create or replace view v_stat_workflow_operations_all as
select
  wo.wf_id, wo.oper_id,
  w.name as wf_name, w.close_date as wf_close_date, w.close_user_id as wf_close_user_id,
  o.name as oper_name, o.begin_status, o.end_status, o.need_sign,
  s1.name as begin_status_name, s2.name as end_status_name,
  wo.END_OPER 
from
  stat_workflow_operations wo,
  stat_workflows w,
  stat_operations o,
  stat_file_statuses s1,
  stat_file_statuses s2
where wo.wf_id = w.id
  and wo.oper_id = o.id
  and o.begin_status = s1.id
  and o.end_status = s2.id;
