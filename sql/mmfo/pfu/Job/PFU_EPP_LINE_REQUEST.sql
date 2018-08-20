begin
    dbms_scheduler.create_job(job_name            => 'PFU_EPP_LINE_REQUEST',
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => 'begin  pfu.pfu_ui.create_epp_batch_request(p_date_from => to_date (sysdate-1,''dd/mm/yyyy''),p_date_to => to_date (sysdate,''dd/mm/yyyy'')); commit; end;',
                              start_date          => to_timestamp_tz('11-04-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                              repeat_interval     => 'FREQ=DAILY;BYDAY=MON,TUE,WED,THU,FRI;BYHOUR=10;BYMINUTE=00;BYSECOND=0',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => false,
                              auto_drop           => false,
                              comments            => 'Щоденний джоб по формуванню запитів до ПФУ для отримання ЕПП');
    dbms_scheduler.disable('PFU_EPP_LINE_REQUEST');
 exception when others 
 then if sqlcode = -27477 then null; end if;
end;
/
