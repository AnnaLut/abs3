create or replace view V_STAT_ACCESS as
select a.ID,
       WF_OPER_ID,
       wo.WF_NAME||'-'||wo.OPER_NAME WF_OPER_NAME,
       ROLE,
       s.role_code,
       s.role_name 
from stat_access a,
     STAFF_ROLE s,
     v_stat_wf_oper wo
where s.id = a.role
  and wo.ID = a.wf_oper_id;
