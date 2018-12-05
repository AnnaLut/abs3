begin 

  dbms_scheduler.disable('SYNC_DOC_EXPORT', force => true);

  for c0 in (select kf from bars.mv_kf) loop
    begin 
      dbms_scheduler.disable('SYNC_DOC_EXPORT_'||c0.kf, force => true);

      declare
        running integer := 1;
      begin
        while running = 1 loop
          select count(*) into running from user_scheduler_running_jobs where job_name = 'SYNC_DOC_EXPORT_'||c0.kf;
          dbms_lock.sleep(5);
        end loop;
      end;

      dbms_scheduler.drop_job('SYNC_DOC_EXPORT_'||c0.kf);
      exception when others then
        if sqlcode = 27476 then null; end if;
    end;

    dbms_scheduler.create_job(job_name            => 'SYNC_DOC_EXPORT_'||c0.kf,
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => 'declare
                                                          l_IsSync integer;
                                                        begin 
                                                         select count (*) into l_IsSync from sync_activity t where t.table_name=''DOC_EXPORT_'||c0.kf||''' and t.status=''IN PROGRESS'';
                                                           if l_IsSync = 0 then
                                                             data_import.sync_doc_export_kf('||c0.kf||');
                                                           end if;
                                                        end;',                              
                              start_date          => to_timestamp_tz('11-04-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                              repeat_interval     => 'Freq=MINUTELY;Interval=1',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => false,
                              auto_drop           => false,
                              comments            => 'Джоб по синхронизации статус по '||c0.kf);
    --dbms_scheduler.enable('SYNC_DOC_EXPORT_'||c0.kf);
  end loop;
end;
/
