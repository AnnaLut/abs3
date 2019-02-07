create or replace view v_stat_files as
with  op as (select distinct wo.wf_id, so.id, so.begin_status, so.end_status, so.need_sign, so.name, end_oper
     from stat_workflow_operations wo,
          stat_operations so,
          stat_access sa,
          V_ROLE_STAFF sr
     where so.id            = wo.oper_id
       and sa.wf_oper_id    = wo.id
       and sr.role_id       = sa.role
       and sr.user_id       = sys_context('bars_global','user_id') )/*,
      oh as (select h.file_id, wo.wf_id, o.end_status, wo.end_oper
          from stat_file_operations_hist h,
               stat_operations o,
               stat_workflow_operations wo
          where h.oper_id = o.id
            and wo.oper_id = o.id)*/

select
 f.id as  file_id,
 f.name as file_name,
 f.zdate as file_date,
 f.file_type_id,
 t.name as  file_type_name,
 f.LOAD_DATE,
 f.load_user_id,
 lu.fio as load_user_fio,
 f.exec_user_id,
 eu.fio as exec_user_fio,
 f.status file_status,
 fs.name as file_status_name,
 f.status_date,
 f.last_version,
 s.id as store_id,
 s.file_size,
 s.file_hash,
 s.file_ver,
 f.signer_id,
 f.sign_date,
 su.fio as signer_fio,
 t.ext_id,
 t.wf_id,
 f.kf,
 op.id oper_id,
 op.name oper_name,
 op.need_sign,
 --oh.end_oper
 f.end_oper,
 (select 1 from dual where f.signer_id = sys_context('bars_global','user_id')) load
from      stat_files f
     join stat_file_storage s   on f.id = s.file_id and f.last_version=s.file_ver
     join stat_file_types t     on f.file_type_id = t.id
     join stat_file_statuses fs on f.status = fs.id
     join staff$base lu         on f.load_user_id = lu.id
left join staff$base eu         on f.exec_user_id = eu.id
left join staff$base su         on f.signer_id = su.id
left join op op                 on op.wf_id = t.wf_id and op.begin_status = f.status
--left join op opend              on opend.wf_id = t.wf_id and opend.end_status = f.status
--left join oh oh                 on oh.file_id = s.file_id and oh.wf_id = t.wf_id and oh.end_status = f.status
where exists (select null from stat_workflow_operations wo,
                               stat_access sa,
                               V_ROLE_STAFF sr
                         where wo.wf_id         = t.wf_id
                           and sa.wf_oper_id    = wo.id
                           and sr.role_id       = sa.role
                           and sr.user_id       = sys_context('bars_global','user_id') )
;
