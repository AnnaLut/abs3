begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.PFU_BLOCK_CARD',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'pfu_ru_file_utl.repeat_block',
                                start_date          => to_date('03-04-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Hourly;ByHour=08, 20',
                                end_date            => to_date(null),
                                job_class           => 'DBMS_JOB$',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '');
exception when others then if (sqlcode = -27477) then null; end if;
end;
/
