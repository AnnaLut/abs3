prompt job BARS_INTGR.XRM_IMPORT_DELTA
begin
    sys.dbms_scheduler.create_job(job_name        => 'BARS_INTGR.XRM_IMPORT_DELTA',
                                  job_type        => 'PLSQL_BLOCK',
                                  job_action      => 'begin bars_intgr.xrm_import.imp_run; end;',
                                  start_date      => to_date('10-07-2017 01:00:00',
                                                             'dd-mm-yyyy hh24:mi:ss'),
                                  repeat_interval => 'Freq=DAILY;BYDAY=MON,TUE,WED,THU,FRI;BYHOUR=7,8,9,10,11,12,13,14,15,16,17,18,19,20',
                                  end_date        => to_date(null),
                                  job_class       => 'DEFAULT_JOB_CLASS',
                                  enabled         => false,
                                  auto_drop       => false,
                                  comments        => 'Подготовка данных для выгрузки в XRM (дельта)');
exception
    when others then
        if sqlcode = -27477 then null; else raise; end if;
end;
/
begin
    sys.dbms_scheduler.set_attribute(name      => 'BARS_INTGR.XRM_IMPORT_DELTA',
                                     attribute => 'REPEAT_INTERVAL',
                                     value     => 'Freq=DAILY;BYDAY=MON,TUE,WED,THU,FRI;BYHOUR=7,8,9,10,11,12,13,14,15,16,17,18,19,20');
end;
/