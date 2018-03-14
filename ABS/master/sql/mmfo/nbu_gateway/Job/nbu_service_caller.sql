begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.NBU_SERVICE_CALLER',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'nbu_data_service.call_service_601',
                                start_date          => to_date('01-01-2000 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Minutely;Interval=1',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '');
end;
/
