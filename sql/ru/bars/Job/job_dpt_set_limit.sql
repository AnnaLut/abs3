begin

  sys.dbms_scheduler.enable(name => 'BARS.JOB_DPT_SET_LIMIT'); 

exception
  when others then
    if sqlcode = -27476 then
      sys.dbms_scheduler.create_job(job_name        => 'BARS.JOB_DPT_SET_LIMIT',
                                    job_type        => 'PLSQL_BLOCK',
                                    job_action      => 'begin BARS.dpt_set_limit; end;',
                                    start_date      => to_date('01-01-2018 05:50:05',
                                                               'dd-mm-yyyy hh24:mi:ss'),
                                    repeat_interval => 'Freq=DAILY;Interval=1',
                                    end_date        => to_date(null),
                                    job_class       => 'DEFAULT_JOB_CLASS',
                                    enabled         => false,
                                    auto_drop       => true,
                                    comments        => 'ƒжоб дл€ пересмотра лимита безнал.депозитов в день первого пополнени€');
    else
      raise;
    end if;
  
end;
/
