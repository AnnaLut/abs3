create or replace view v_stat_wf_oper as
select wo.ID,
       wo.WF_ID,
       w.name WF_NAME,
       wo.OPER_ID,
       o.name OPER_NAME,
       wo.END_OPER
from stat_workflow_operations wo,
     stat_workflows w,
     stat_operations o
where w.id = wo.WF_ID
  and o.id = wo.oper_id;
