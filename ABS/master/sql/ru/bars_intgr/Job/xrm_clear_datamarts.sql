prompt job BARS_INTGR.XRM_CLEAR_DATAMARTS
begin
    sys.dbms_scheduler.create_job(job_name        => 'BARS_INTGR.XRM_CLEAR_DATAMARTS',
                                  job_type        => 'PLSQL_BLOCK',
                                  job_action      => 'begin bars_intgr.xrm_import.clear_datamarts; end;',
                                  start_date      => to_date('10-07-2017 01:00:00',
                                                             'dd-mm-yyyy hh24:mi:ss'),
                                  repeat_interval => 'Freq=DAILY;BYHOUR=0;BYMINUTE=0;',
                                  end_date        => to_date(null),
                                  job_class       => 'DEFAULT_JOB_CLASS',
                                  enabled         => true,
                                  auto_drop       => false,
                                  comments        => 'Очистка витрин дельты');
exception
    when others then
        if sqlcode = -27477 then null; else raise; end if;
end;
/