begin 
  for c0 in (select kf from bars.mv_kf) loop
    begin 
      dbms_scheduler.disable('IMP_CORP2_DOC_'||c0.kf, force => true);

      declare
        running integer := 1;
      begin
        while running = 1 loop
          select count(*) into running from user_scheduler_running_jobs where job_name = 'IMP_CORP2_DOC_'||c0.kf;
          dbms_lock.sleep(5);
        end loop;
      end;

      dbms_scheduler.drop_job('IMP_CORP2_DOC_'||c0.kf);
      exception when others then
        if sqlcode = 27476 then null; end if;
    end;

    dbms_scheduler.create_job(job_name            => 'IMP_CORP2_DOC_'||c0.kf,
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => 'BEGIN barsaq.data_import.import_documents_kf('''||c0.kf||'''); END;',
                              start_date          => to_timestamp_tz('11-04-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                              repeat_interval     => 'Freq=MINUTELY;Interval=1',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => false,
                              auto_drop           => false,
                              comments            => 'Джоб по загрузке документов из Corp2 по '||c0.kf);
    dbms_scheduler.enable('IMP_CORP2_DOC_'||c0.kf);
  end loop;
end;
/