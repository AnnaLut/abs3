prompt ====================================
prompt Create job sto_pm_auto_storno 
prompt ====================================


BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.STO_PM_AUTO_STORNO');
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

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.STO_PM_AUTO_STORNO',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'bars.sto_payment_utl.auto_storno',
                                start_date          => to_date('01-01-2000 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => '');
end;
/
