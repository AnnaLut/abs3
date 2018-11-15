PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Job/job_clean_tms_audit.sql =========*** Run ***
PROMPT ===================================================================================== 

begin

  sys.dbms_scheduler.enable(name => 'BARS.job_clean_tms_audit'); 

exception
  when others then
    if sqlcode = -27476 then
      sys.dbms_scheduler.create_job(job_name        => 'BARS.job_clean_tms_audit',
                                    job_type        => 'PLSQL_BLOCK',
                                    job_action      => 'begin BARS.TMS_UTL.p_clean_tmsaudit; end;',
                                    start_date      => to_date('01-03-2019 20:00:00',
                                                               'dd-mm-yyyy hh24:mi:ss'),
                                    repeat_interval => 'Freq=MONTHLY; Interval=6',
                                    end_date        => to_date(null),
                                    job_class       => 'DEFAULT_JOB_CLASS',
                                    enabled         => false,
                                    auto_drop       => true,
                                    comments        => 'Очистка логов логирования збд, дата < sysdate-6 мес');
    else
      raise;
    end if;
  
end;
/
show errors

PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Job/job_clean_tms_audit.sql =========*** Run ***
PROMPT ===================================================================================== 
