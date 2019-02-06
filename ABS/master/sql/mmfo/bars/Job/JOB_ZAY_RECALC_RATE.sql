
begin
  sys.dbms_scheduler.create_job(job_name        => 'BARS.JOB_ZAY_RECALC_RATE',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'BARS.P_ZAY_RECALC_RATE',
                                start_date          => to_date('06-02-2019 06:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=DAILY',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Перерахунок еквівалента та курсу біржових заявок на добовому контролі');
end;
/
