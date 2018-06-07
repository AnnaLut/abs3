  begin
    begin 
      dbms_scheduler.disable('CREATE_DOC_CORP2', force => true);

      declare
        running integer := 1;
      begin
        while running = 1 loop
          select count(*) into running from user_scheduler_running_jobs where job_name = 'CREATE_DOC_CORP2';
          dbms_lock.sleep(5);
        end loop;
      end;

      dbms_scheduler.drop_job('CREATE_DOC_CORP2');
      exception when others then
        if sqlcode = 27476 then null; end if;
    end;

    dbms_scheduler.create_job(job_name            => 'CREATE_DOC_CORP2',
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => 'BEGIN barsaq.bars_docsync.async_pay_documents; END;',
                              start_date          => to_timestamp_tz('11-04-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                              repeat_interval     => 'Freq=MINUTELY;Interval=1',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => false,
                              auto_drop           => false,
                              comments            => 'Джоб по созданию документов Corp2');
    dbms_scheduler.enable('CREATE_DOC_CORP2');
  end;
 /