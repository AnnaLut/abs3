   begin
    SYS.DBMS_SCHEDULER.DROP_JOB( job_name => 'JOB_DOC2AutoKassa' );
  exception
    when others then
      null;
  end;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.JOB_DOC2AutoKassa',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin clb2autokassa.process_queue; end;',
                                schedule_name       => 'BARS.INTERVAL_10_MINUTES',
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'процес сканування черги документів, надіслані через інтернет-клієнт-банк і є заявкою на підкріплення каси');
exception when others then if (sqlcode = -27477) then null; end if;
end;
/