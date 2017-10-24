prompt ====================================
prompt Create job EBK_GROUP_DUPLICATE_JOB
prompt ====================================
begin
   begin
     SYS.DBMS_SCHEDULER.DROP_JOB
       (job_name  => 'EBK_GROUP_DUPLICATE_JOB');
    exception when others then null;
   end;
sys.dbms_scheduler.create_job
    (
       job_name        => 'EBK_GROUP_DUPLICATE_JOB'
      ,start_date      => to_timestamp_tz('2015/06/17 08:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY; BYHOUR=8,13'
      ,end_date        => null
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin ebk_dup_wform_utl.create_group_duplicate; ebkc_pack.create_group_duplicate; end;'
      ,comments        => 'Джоб для формирования групп дубликатов утром и в обед'
      ,enabled         => true
    );
--sys.dbms_scheduler.disable(name => 'EBK_GROUP_DUPLICATE_JOB');
end;
/

