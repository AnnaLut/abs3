BEGIN
  BEGIN
    dbms_scheduler.drop_job(job_name => 'BARS.BATCH_PORCESSING_JOB');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -27475 THEN
        NULL;
      ELSE
        RAISE;
      END IF;
  END;
  sys.dbms_scheduler.create_job(job_name        => 'BARS.BATCH_PORCESSING_JOB'
                               ,job_type        => 'STORED_PROCEDURE'
                               ,job_action      => 'XRM_INTEGRATION_OE.PROCESS_TRANSPORT_UNIT'
                               ,start_date      => to_date('01-01-2017 04:44:40'
                                                          ,'dd-mm-yyyy hh24:mi:ss')
                               ,repeat_interval => 'Freq=MINUTELY;Interval=30'
                               ,end_date        => to_date(NULL)
                               ,job_class       => 'DEFAULT_JOB_CLASS'
                               ,enabled         => TRUE
                               ,auto_drop       => TRUE
                               ,comments        => 'run transport_utl.process_transport_unit every 30 min');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -27477 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;
/
