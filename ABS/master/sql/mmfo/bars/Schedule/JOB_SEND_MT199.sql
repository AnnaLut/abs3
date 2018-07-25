Prompt Scheduler Job JOB_SEND_MT199;
--
-- JOB_SEND_MT199  (Scheduler Job) 
--
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB('BARS.JOB_SEND_MT199',true);
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BARS.JOB_SEND_MT199'
      ,schedule_name   => 'BARS.INTERVAL_2_MINUTES'
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => ' begin
                                 bars_swift_msg.job_send_mt199();
                                 bars_swift_msg.job_send_mt199_ru();
                                 bars_swift_msg.job_send_mt199_tr2client();
                                 bars_swift_msg.job_send_mt199_ru_tr2client();
                                 bars_swift_msg.job_send_mt199_tr2tr2client();
                                 bars_swift_msg.job_send_mt199_ru_tr2tr2client();
  end;'
      ,comments        => 'Відправка MT199'
    );
  
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BARS.JOB_SEND_MT199');
END;
/