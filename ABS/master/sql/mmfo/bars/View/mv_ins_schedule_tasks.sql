

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MV_INS_SCHEDULE_TASKS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view MV_INS_SCHEDULE_TASKS ***

  CREATE OR REPLACE FORCE VIEW BARS.MV_INS_SCHEDULE_TASKS ("TYPE_ID", "TYPE_NAME", "PRIORITY", "DEAL_ID", "STATUS_ID", "STATUS_NAME", "PLAN_DATE", "DAYS") AS 
  select tt.id as type_id,
       tt.name as type_name,
       tt.priority,
       d.id as deal_id,
       ts.id as status_id,
       ts.name as status_name,
       d.edate as plan_date,
       case (ts.id)
         when 'NOTDONE' then
          round(sysdate - d.edate)
         when 'WAITING' then
          round(d.edate - sysdate)
         else
          null
       end days
  from ins_deals d, ins_task_types tt, ins_task_statuses ts
 where d.status_id in ('ON', 'OFF')
   and tt.id = 'RENEW'
   and d.renew_need = 1
   and d.renew_newid is null
   and ts.id in ('NOTDONE', 'WAITING')
   and nvl(ts.days_to, (sysdate - d.edate)) >= (sysdate - d.edate)
   and (sysdate - d.edate) > nvl(ts.days_from, (sysdate - d.edate))
union all
select tt.id as type_id,
       tt.name as type_name,
       tt.priority,
       ps.deal_id as deal_id,
       ts.id as status_id,
       ts.name as status_name,
       ps.plan_date,
       case (ts.id)
         when 'NOTDONE' then
          trunc(sysdate - ps.plan_date)
         when 'WAITING' then
          trunc(ps.plan_date - sysdate)
         else
          null
       end days
  from ins_deals d, ins_payments_schedule ps, ins_task_types tt, ins_task_statuses ts
 where d.status_id in ('NEW', 'NEW_ADD', 'ON', 'OFF')
   and d.id = ps.deal_id
   and tt.id = 'PAY'
   and ps.payed = 0
   and ts.id in ('NOTDONE', 'WAITING')
   and nvl(ts.days_to, (sysdate - ps.plan_date)) >=
       (sysdate - ps.plan_date)
   and (sysdate - ps.plan_date) >
       nvl(ts.days_from, (sysdate - ps.plan_date));



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MV_INS_SCHEDULE_TASKS.sql =========*** 
PROMPT ===================================================================================== 
