Prompt Scheduler Job JOB_SEND_MT199_STATUS_004;
--
-- JOB_SEND_MT199_STATUS_004  (Scheduler Job) 
--
BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.JOB_SEND_MT199_STATUS_004');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BARS.JOB_SEND_MT199_STATUS_004'
      ,start_date      => TO_TIMESTAMP_TZ('2016/08/09 02:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY; INTERVAL=1; BYHOUR=18; BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                                bars_swift_msg.job_send_status_004;  
                                bars_swift_msg.job_send_mt199_tr;
                                bars_swift_msg.job_send_mt199_ru_tr;

end;'
      ,comments        => '��������� ��199 ��� ��� ��103 �� ���� �� ���� ��������'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.JOB_SEND_MT199_STATUS_004'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BARS.JOB_SEND_MT199_STATUS_004');
END;
/
