prompt job BARS.DAILY_COMPRESS_AUDIT
begin
  sys.dbms_scheduler.enable(name => 'BARS.DAILY_COMPRESS_AUDIT');
exception
  when others then
    if sqlcode = -27476 then
      begin
        sys.dbms_scheduler.create_job(job_name        => 'BARS.DAILY_COMPRESS_AUDIT',
                                      job_type        => 'PLSQL_BLOCK',
                                      job_action      => 'begin bars_audit_adm.compress_partition(trunc(sysdate)-1); end;',
                                      start_date      => to_date('10-07-2017 01:00:00',
                                                                 'dd-mm-yyyy hh24:mi:ss'),
                                      repeat_interval => 'Freq=Daily;BYHOUR=01;BYMINUTE=00;BYSECOND=0',
                                      end_date        => to_date(null),
                                      job_class       => 'DEFAULT_JOB_CLASS',
                                      enabled         => true,
                                      auto_drop       => false,
                                      comments        => '—жатие предыдущей секции sec_audit');
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
