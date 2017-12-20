--delete from bars.tmp_all_enabled_jobs;
--commit;

-- добавляем еще не отключенныеджобы

insert into bars.tmp_all_enabled_jobs(owner, job_type, job_name)
select owner, 'S', job_name from dba_scheduler_jobs where
job_name like 'CRM_UPLOAD_%';


commit;