BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
      ,start_date      => TO_TIMESTAMP_TZ('2017/05/31 22:59:00.000000 +02:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=2'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin BARS.BARS_SMS_ACC.PREPARE_SUBMIT_DATA; COMMIT; end;'
      ,comments        => '���� ��� �������� ��������� sms (GMSU)'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.BARS_SMS_PREPARE_SUBMIT_DATA'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);
exception when others then if (sqlcode = -27477) then null; else raise; end if;
END;
/
