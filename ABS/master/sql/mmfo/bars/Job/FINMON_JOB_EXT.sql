begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.FINMON_JOB_EXT',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'P_JOB_FM_DOCCHECK_EXT',
                                schedule_name       => 'BARS.INTERVAL_2_MINUTES',
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Финмониторинг - проверка документов (внешние)');
exception
    when others then
        if sqlcode = -27477 then null; else raise; end if;
end;
/
