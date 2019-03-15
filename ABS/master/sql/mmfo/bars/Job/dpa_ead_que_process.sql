PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/job/dpa_ead_que_process.sql =========*** Run *** 
PROMPT ===================================================================================== 

begin
  /*drop old job is exists*/
  begin
    dbms_scheduler.drop_job(job_name => 'bars.dpa_ead_que_process');
  exception when others then
    if sqlcode = -27475 then 
      null;
    elsif sqlcode = -27478 then -- is running
      dbms_scheduler.stop_job(job_name => 'bars.dpa_ead_que_process', force => true);
      dbms_scheduler.drop_job(job_name => 'bars.dpa_ead_que_process');
    else 
      raise; 
    end if;
  end;

  begin
    dbms_scheduler.create_job(job_name            => 'bars.dpa_ead_que_process',
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => 'begin bars.bars_dpa.send_pdf2ea; end;',
                              number_of_arguments => 0,
                              start_date          => sysdate,
                              repeat_interval     => 'FREQ=DAILY;ByHour=4',
                              end_date            => NULL,
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => TRUE,
                              comments            => 'Формування та відправка PDF звіту по відкритим/закритим рахункам в ЕА',
                              auto_drop           => FALSE);
  exception when others then
    if sqlcode = -27477 then 
      null;
    else 
      raise; 
    end if;
  end;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/job/dpa_ead_que_process.sql =========*** End *** 
PROMPT ===================================================================================== 
