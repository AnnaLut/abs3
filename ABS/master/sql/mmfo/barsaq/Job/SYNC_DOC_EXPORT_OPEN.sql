begin
  sys.dbms_scheduler.create_job(job_name            => 'BARSAQ.SYNC_DOC_EXPORT_OPEN',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin data_import.sync_doc_export_open; end;',
                                start_date          => to_date('28-05-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=HOURLY;ByHour=09',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'Завдання для синхронізації таблиць старих статусів DOC_EXPORT');
end;
/
