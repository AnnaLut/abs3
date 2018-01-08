BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.NBUR_CHECK_QUEUE_2_304665');
exception when others then if (sqlcode = -27475) then null; end if;    
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BARS.NBUR_CHECK_QUEUE_2_304665'
      ,start_date      => TO_TIMESTAMP_TZ('2017/08/22 00:03:00.000000 +03:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MINUTELY; INTERVAL=15'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      => 'DECLARE 
               RetVal NUMBER;
             BEGIN 
               bars.bc.home;
               RetVal := BARS.NBUR_QUEUE.F_CHECK_QUEUE_WITHOUT_OBJECTS(1, ''304665'');
               COMMIT; 
             END;'
      ,comments        => 'Перевірка черги файлів звітності'
    );
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'MAX_FAILURES');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'MAX_RUNS');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'STOP_ON_WINDOW_CLOSE'
     ,value     => FALSE);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'SCHEDULE_LIMIT');
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.NBUR_CHECK_QUEUE_2_304665'
     ,attribute => 'AUTO_DROP'
     ,value     => TRUE);

  SYS.DBMS_SCHEDULER.ENABLE
    (name                  => 'BARS.NBUR_CHECK_QUEUE_2_304665');
exception when others then if (sqlcode = -27477) then null; end if;        
END;
/