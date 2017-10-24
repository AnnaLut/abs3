BEGIN
  DBMS_SCHEDULER.DROP_JOB ('BARS.BARS_COMPEN_STATE_OPER');
  exception
  when others then
   if sqlcode = -27475 then null; 
     else raise;
   end if;  
END;
/

begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.BARS_COMPEN_STATE_OPER',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'crkr_compen_web.request_grc_state_oper',
                                start_date          => to_date('10-10-2016 10:10:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Hourly;Interval=1',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Запит в ГРЦ по стану відправлених раніше документів');
exception
  when others then
   if sqlcode = -27477 then null; 
     else raise;
   end if;  
end;
/