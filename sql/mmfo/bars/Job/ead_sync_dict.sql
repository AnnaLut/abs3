PROMPT *** Disable scheduled job EAD_SYNC_DICT ***
execute dbms_scheduler.disable('EAD_SYNC_DICT', force => true);

PROMPT *** Waiting for the job to be stopped... ***
declare
  running integer := 1;
begin
  while running = 1 loop
    select count(*) into running from user_scheduler_running_jobs where job_name = 'EAD_SYNC_DICT';
    dbms_lock.sleep(5);
  end loop;
end;
/

PROMPT *** Drop scheduled job EAD_SYNC_DICT ***
execute dbms_scheduler.drop_job('EAD_SYNC_DICT');

PROMPT *** Create scheduled job EAD_SYNC_DICT ***
begin
      dbms_scheduler.create_job(job_name            => 'BARS.EAD_SYNC_DICT',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => '
begin
  for k in (select replace(key, ''ead.ServiceUrl'') as kf from bars.web_barsconfig where key like ''ead.ServiceUrl%'' and val not like ''-%'')
  loop
    ead_pack.msg_create(''DICT'', ''EA-UB'', k.kf);
    ead_pack.msg_process(tools.gn_dummy, k.kf);
  end loop;
end;',
                                start_date          => to_timestamp_tz('19-11-2013 Europe/Kiev', 'dd-mm-yyyy tzr'),
                                repeat_interval     => 'Freq=DAILY;Interval=1',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'Джоб для передачі довідників');

  dbms_scheduler.enable('BARS.EAD_SYNC');
end;
/