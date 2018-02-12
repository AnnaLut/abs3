PROMPT *** Disable scheduled job EAD_PROCESS_UO_335106 ***
execute dbms_scheduler.disable('EAD_PROCESS_UO_335106', force => true);

PROMPT *** Waiting for the job to be stopped... ***
declare
  running integer := 1;
begin
  while running = 1 loop
    select count(*) into running from user_scheduler_running_jobs where job_name = 'EAD_PROCESS_UO_335106';
    dbms_lock.sleep(5);
  end loop;
end;
/

PROMPT *** Drop scheduled job EAD_PROCESS_UO_335106 ***
execute dbms_scheduler.drop_job('EAD_PROCESS_UO_335106');

PROMPT *** Create scheduled job EAD_PROCESS_UO_335106 ***
begin
      dbms_scheduler.create_job(job_name            => 'BARS.EAD_PROCESS_UO_335106',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => '
BEGIN
     
    ead_pack.type_process (''UCLIENT'', ''335106''); 
    ead_pack.type_process (''UAGR'', ''335106'');
    ead_pack.type_process (''UACC'', ''335106'');

END;',
                                start_date          => to_timestamp_tz('19-11-2013 Europe/Kiev', 'dd-mm-yyyy tzr'),
                                repeat_interval     => 'Freq=MINUTELY;Interval=5',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'Джоб для передачи сообщений в ЭА(юр.лица)');
  dbms_scheduler.enable('BARS.EAD_PROCESS_UO_335106');
end;
/
