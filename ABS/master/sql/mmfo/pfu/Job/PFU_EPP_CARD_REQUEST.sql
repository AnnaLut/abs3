begin
    dbms_scheduler.create_job(job_name            => 'PFU_EPP_CARD_REQUEST',
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => 'begin pfu.pfu_service_utl.prepare_checkissuecard; commit; end;',
                              start_date          => to_timestamp_tz('11-04-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                              repeat_interval     => 'Freq=Hourly;Interval=2',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => false,
                              auto_drop           => false,
                              comments            => 'Щоденний джоб по формуванню запитів до РУ стосовно стану випуску карток по ЕПП');
    dbms_scheduler.disable('PFU_EPP_CARD_REQUEST');
 exception when others 
 then if sqlcode = -27477 then null; end if;
end;
/


