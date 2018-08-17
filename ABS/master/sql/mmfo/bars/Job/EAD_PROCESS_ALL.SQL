PROMPT *** Disable scheduled jobs EAD ***
begin
  for i in (select job_name
              from dba_scheduler_jobs
             where job_name like 'EAD_PROCESS%') loop
    dbms_scheduler.disable(name => i.job_name, force => true);
  end loop;
end;    
/

PROMPT *** Drop scheduled job EAD_PROCESS_ALL ***
execute dbms_scheduler.drop_job('EAD_PROCESS_ALL');

PROMPT *** Create scheduled job EAD_PROCESS_ALL ***
begin
      dbms_scheduler.create_job(job_name            => 'BARS.EAD_PROCESS_ALL',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => '
BEGIN
    ead_pack.type_process ();
END;',
                                start_date          => to_timestamp_tz('19-11-2013 Europe/Kiev', 'dd-mm-yyyy tzr'),
                                repeat_interval     => 'Freq=MINUTELY;Interval=3',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'Джоб для передачи сообщений в ЭА(по всем МФО и типам)');
  dbms_scheduler.enable('BARS.EAD_PROCESS_ALL');
end;
/
