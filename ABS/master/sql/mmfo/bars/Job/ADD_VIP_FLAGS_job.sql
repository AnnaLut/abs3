BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.ADD_VIP_FLAGS');
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
       job_name        => 'BARS.ADD_VIP_FLAGS'
      ,start_date      => TO_TIMESTAMP_TZ('2016/08/09 02:00:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=DAILY; INTERVAL=1; BYHOUR=2; BYMINUTE=0;BYSECOND=0'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'begin
                                vip_adm.add_flags;
                                commit;
                           end;'
      ,comments        => 'Додавання до VIP_FLAGS з Сегментів Клієнта'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.ADD_VIP_FLAGS'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BARS.ADD_VIP_FLAGS');
END;
/
commit;
/