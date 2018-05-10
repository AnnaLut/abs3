PROMPT *** Disable scheduled job EAD_SYNC ***
execute dbms_scheduler.disable('EAD_SYNC', force => true);

PROMPT *** Waiting for the job to be stopped... ***
declare
  running integer := 1;
begin
  while running = 1 loop
    select count(*) into running from user_scheduler_running_jobs where job_name = 'EAD_SYNC';
    dbms_lock.sleep(5);
  end loop;
end;
/

PROMPT *** Drop scheduled job EAD_SYNC ***
execute dbms_scheduler.drop_job('EAD_SYNC');


PROMPT *** Create scheduled job EAD_SYNC ***
BEGIN
      dbms_scheduler.create_job(job_name            => 'BARS.EAD_SYNC',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => '
BEGIN
      ead_pack.cdc_client; 
      ead_pack.cdc_agr; 
      ead_pack.cdc_acc;
      ead_pack.cdc_act; 
      ead_pack.cdc_doc; 
      commit;
  
      ead_pack.type_process(''CLIENT''); 
      ead_pack.type_process(''AGR''); 
      ead_pack.type_process(''ACC''); 
      ead_pack.type_process(''ACT''); 
      ead_pack.type_process(''DOC'');
      commit; 
END;',
                                start_date          => to_timestamp_tz('19-11-2013 Europe/Kiev', 'dd-mm-yyyy tzr'),
                                repeat_interval     => 'Freq=MINUTELY;Interval=5',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'Джоб для передачи сообщений в ЭА(физ.лица)');

  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.EAD_SYNC'
     ,attribute => 'SCHEDULE_LIMIT');

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BARS.EAD_SYNC');


EXCEPTION
	WHEN OTHERS THEN
		IF SQLCODE = -27477 THEN
			NULL; -- suppresses exception
		ELSE
			RAISE;
		END IF;

END;
/
