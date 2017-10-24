BEGIN
  SYS.DBMS_SCHEDULER.CREATE_JOB
    (
       job_name        => 'BARS.OTCN_FILL_K140'
      ,start_date      => TO_TIMESTAMP_TZ('2017/09/01 03:00:00.000000 +02:00','yyyy/mm/dd hh24:mi:ss.ff tzr')
      ,repeat_interval => 'FREQ=MONTHLY; INTERVAL=1'
      ,end_date        => NULL
      ,job_class       => 'DEFAULT_JOB_CLASS'
      ,job_type        => 'PLSQL_BLOCK'
      ,job_action      =>  'begin
                                p_otc_fill_k140(trunc(sysdate));
                            end;'
      ,comments        => 'Заповнення параметру K140 для клієнтів'
    );
    
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'RESTARTABLE'
     ,value     => FALSE);
     
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'LOGGING_LEVEL'
     ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
     
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'MAX_FAILURES');
     
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'MAX_RUNS');
     
  BEGIN
    SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
      ( name      => 'BARS.OTCN_FILL_K140'
       ,attribute => 'STOP_ON_WINDOW_CLOSE'
       ,value     => FALSE);
  EXCEPTION
    -- could fail if program is of type EXECUTABLE...
    WHEN OTHERS THEN
      NULL;
  END;
  
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'JOB_PRIORITY'
     ,value     => 3);
     
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'SCHEDULE_LIMIT');
     
  SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
    ( name      => 'BARS.OTCN_FILL_K140'
     ,attribute => 'AUTO_DROP'
     ,value     => FALSE);
     
  SYS.DBMS_SCHEDULER.ENABLE
    (name => 'BARS.OTCN_FILL_K140');
    
END;
/