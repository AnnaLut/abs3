declare
    sql_job clob;
begin
    for k in (select kf from mv_kf order by 1) 
    loop    
        sql_job := 
           'BEGIN
              BEGIN
                 SYS.DBMS_SCHEDULER.DROP_JOB
                    (job_name  => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||''');
              EXCEPTION
                when others then null;
              END;

              SYS.DBMS_SCHEDULER.CREATE_JOB
                (
                   job_name        => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                  ,start_date      => sysdate
                  ,repeat_interval => ''Freq=MINUTELY;Interval=5''
                  ,end_date        => NULL
                  ,job_class       => ''DEFAULT_JOB_CLASS''
                  ,job_type        => ''PLSQL_BLOCK'' 
                  ,job_action      => ''DECLARE 
                           RetVal NUMBER;
                         BEGIN 
                           bars.bc.home;
                           RetVal := BARS.NBUR_QUEUE.F_CHECK_QUEUE_WITHOUT_OBJECTS(3, to_char('||k.kf||'));
                           COMMIT; 
                         END; ''
                  ,comments        =>  ''Перевірка черги файлів звітності (приорітетні файли) ''
                );
                
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''RESTARTABLE''
                 ,value     => FALSE);
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''LOGGING_LEVEL''
                 ,value     => SYS.DBMS_SCHEDULER.LOGGING_OFF);
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''MAX_FAILURES'');
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''MAX_RUNS'');
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''STOP_ON_WINDOW_CLOSE''
                 ,value     => FALSE);
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''JOB_PRIORITY''
                 ,value     => 3);
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE_NULL
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''SCHEDULE_LIMIT'');
                 
              SYS.DBMS_SCHEDULER.SET_ATTRIBUTE
                ( name      => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||'''
                 ,attribute => ''AUTO_DROP''
                 ,value     => TRUE);

              SYS.DBMS_SCHEDULER.ENABLE
                (name                  => ''BARS.NBUR_CHECK_QUEUE_4_'||k.kf||''');
            END; '; 
            
        execute immediate sql_job;
    end loop;
end;            
/
