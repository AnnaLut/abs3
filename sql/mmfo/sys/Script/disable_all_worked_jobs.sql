--delete from bars.tmp_all_enabled_jobs;
--commit;

-- добавляем еще не отключенныеджобы

insert into bars.tmp_all_enabled_jobs(owner, job_type, job_name)
select owner, 'S', job_name from dba_scheduler_jobs where
job_name in (
'NBUR_CHECK_QUEUE_1_300465',
           'NBUR_CHECK_QUEUE_1_304665',
           'NBUR_CHECK_QUEUE_1_322669',
           'NBUR_CHECK_QUEUE_1_324805',
           'NBUR_CHECK_QUEUE_1_335106',
           'NBUR_CHECK_QUEUE_1_351823',
           'NBUR_CHECK_QUEUE_2_300465',
           'NBUR_CHECK_QUEUE_2_304665',
           'NBUR_CHECK_QUEUE_2_322669',
           'NBUR_CHECK_QUEUE_2_324805',
           'NBUR_CHECK_QUEUE_2_335106',
           'NBUR_CHECK_QUEUE_2_351823',
           'NBUR_CHECK_QUEUE_3_300465',
           'NBUR_CHECK_QUEUE_3_304665',
           'NBUR_CHECK_QUEUE_3_322669',
           'NBUR_CHECK_QUEUE_3_324805',
           'NBUR_CHECK_QUEUE_3_335106',
           'NBUR_CHECK_QUEUE_3_351823',
           'IMPORT_DAY')
     or job_name like 'CRM_UPLOAD_%';


commit;