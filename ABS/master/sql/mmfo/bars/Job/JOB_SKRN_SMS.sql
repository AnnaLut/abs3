begin
  sys.dbms_scheduler.enable(name => 'BARS.JOB_SKRN_SMS');
exception
  when others then
    if sqlcode = -27476 then
      begin
        sys.dbms_scheduler.create_job(job_name        => 'BARS.JOB_SKRN_SMS',
                                      job_type        => 'PLSQL_BLOCK',
                                      job_action      => 'begin safe_deposit.skrn_send_sms; end;',
                                      start_date      => to_date('10-07-2017 11:00:00',
                                                                 'dd-mm-yyyy hh24:mi:ss'),
                                      repeat_interval => 'Freq=Daily;Interval=1',
                                      end_date        => to_date(null),
                                      job_class       => 'DEFAULT_JOB_CLASS',
                                      enabled         => false,
                                      auto_drop       => true,
                                      comments        => 'Формирование СМС сообщений по деп. сейфам');
      exception
        when others then
          if sqlcode = -27477 then
            null;
          else
            raise;
          end if;
      end;
    else
      raise;
    end if;
end;
/

