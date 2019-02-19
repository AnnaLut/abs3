begin
  sys.dbms_scheduler.create_job(job_name        => 'BARS.SUBSIDY_PAYMENT_JOB',
                                job_type        => 'PLSQL_BLOCK',
                                job_action      => 'begin
    bc.go(300465);
    subsidy.processing_payments();
  end;',
                                start_date      => to_date(null),
                                repeat_interval => 'Freq=Hourly;Interval=3',
                                end_date        => to_date(null),
                                job_class       => 'DEFAULT_JOB_CLASS',
                                enabled         => false,
                                auto_drop       => false,
                                comments        => '');

exception
  when others then
    if sqlcode = -27477 then
      null;
    else
      raise;
    end if;
end;
/
