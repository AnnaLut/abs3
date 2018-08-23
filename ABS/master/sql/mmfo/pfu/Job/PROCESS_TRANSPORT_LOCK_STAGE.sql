begin
  sys.dbms_scheduler.create_job(job_name            => 'PFU.PROCESS_TRANSPORT_LOCK_STAGE',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'pfu.pfu_service_utl.process_transport_lock_stage',
                                start_date          => to_date('01-01-2000 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Hourly;Interval=1',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'ВПО блокування та розблокування рахунків за запитом ПЦ');
end;
/
