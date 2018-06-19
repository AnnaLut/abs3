prompt Разделение FINMON_JOB на две составляющие
begin
dbms_scheduler.drop_job(job_name => 'FINMON_JOB', force => true);
exception
    when others then
        if sqlcode = -27475 then null; else raise; end if;
end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.FINMON_JOB_INT',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'P_JOB_FM_DOCCHECK_INT',
                                schedule_name       => 'BARS.INTERVAL_2_MINUTES',
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Финмониторинг - проверка документов (внутренние)');
exception
    when others then
        if sqlcode = -27477 then null; else raise; end if;
end;
/

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
