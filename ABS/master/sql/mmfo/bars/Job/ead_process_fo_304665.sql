PROMPT *** Disable scheduled job EAD_PROCESS_FO_304665 ***
execute dbms_scheduler.disable('EAD_PROCESS_FO_304665', force => true);

PROMPT *** Waiting for the job to be stopped... ***
declare
  running integer := 1;
begin
  while running = 1 loop
    select count(*) into running from user_scheduler_running_jobs where job_name = 'EAD_PROCESS_FO_304665';
    dbms_lock.sleep(5);
  end loop;
end;
/

PROMPT *** Drop scheduled job EAD_PROCESS_FO_304665 ***
execute dbms_scheduler.drop_job('EAD_PROCESS_FO_304665');

PROMPT *** Create scheduled job EAD_PROCESS_FO_304665 ***
begin
      dbms_scheduler.create_job(job_name            => 'BARS.EAD_PROCESS_FO_304665',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => '
BEGIN
  
     ead_pack.type_process(''CLIENT'', ''304665''); 
     ead_pack.type_process(''AGR'', ''304665''); 
     ead_pack.type_process(''ACC'', ''304665'');
     ead_pack.type_process(''ACT'', ''304665''); 
     ead_pack.type_process(''DOC'', ''304665'');

END;',
                                start_date          => to_timestamp_tz('19-11-2013 Europe/Kiev', 'dd-mm-yyyy tzr'),
                                repeat_interval     => 'Freq=MINUTELY;Interval=5',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => '���� ��� �������� ��������� � ��(���.����)');
  dbms_scheduler.enable('BARS.EAD_PROCESS_FO_304665');
end;
/
