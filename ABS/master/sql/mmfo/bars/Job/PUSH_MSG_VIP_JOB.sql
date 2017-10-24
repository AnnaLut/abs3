BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.PUSH_MSG_VIP_JOB');
EXCEPTION
   WHEN OTHERS
   THEN
      IF SQLCODE = -27475
      THEN
         NULL;
      ELSE
         RAISE;
      END IF;  
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BARS.PUSH_MSG_VIP_JOB'
      ,start_date      => TO_TIMESTAMP_TZ('2016/08/09 02:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY; INTERVAL=1; BYHOUR=1; BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin PUSH_MSG_VIP; end;'
      ,comments        => 'Формування повідомлень відповідальним менеджерам по VIP'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.PUSH_MSG_VIP_JOB'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BARS.PUSH_MSG_VIP_JOB');
END;
/
commit;
/