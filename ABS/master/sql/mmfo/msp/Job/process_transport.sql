begin
  dbms_scheduler.drop_job(job_name  => 'MSP.PROCESS_TRANSPORT');
exception when others then
  if (sqlcode = -27475) then null;
  else raise; end if;
end;
/


begin
  sys.dbms_scheduler.create_job(job_name            => 'MSP.PROCESS_TRANSPORT',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin
    msp_utl.prepare_check_state;
    msp_utl.process_receipt;
  end;',
                                start_date          => to_date('27-12-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Minutely;Interval=2',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '');
end;
/
