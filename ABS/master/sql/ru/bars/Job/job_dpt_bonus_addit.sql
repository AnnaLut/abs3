begin

  sys.dbms_scheduler.enable(name => 'BARS.JOB_DPT_BONUS_ADDIT'); 

exception
  when others then
    if sqlcode = -27476 then
      sys.dbms_scheduler.create_job(job_name        => 'BARS.JOB_DPT_BONUS_ADDIT',
                                    job_type        => 'PLSQL_BLOCK',
                                    job_action      => 'begin BARS.dpt_bonus_addit; end;',
                                    start_date      => to_date('01-01-2018 20:00:00',
                                                               'dd-mm-yyyy hh24:mi:ss'),
                                    repeat_interval => 'Freq=DAILY;Interval=1',
                                    end_date        => to_date(null),
                                    job_class       => 'DEFAULT_JOB_CLASS',
                                    enabled         => false,
                                    auto_drop       => true,
                                    comments        => 'Джоб для пересчета бонусов при пополнении вкладов');
    elsif
      sqlcode = -27477 then
      null;
    else
      raise;
    end if;
  
end;
/
commit;

