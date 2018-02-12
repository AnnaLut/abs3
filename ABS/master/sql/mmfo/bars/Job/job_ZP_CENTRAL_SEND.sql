begin
  dbms_scheduler.drop_job(job_name  => 'bars.ZP_CENTRAL_SEND');
exception when others then
  if (sqlcode = -27475) then null;
  else raise; end if;
end;
/
 
begin
  dbms_scheduler.create_job(job_name        => 'bars.ZP_CENTRAL_SEND',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => 'begin zp.send_central; end;',
                            number_of_arguments => 0,
                            start_date          => TO_TIMESTAMP('2017/07/07 13:10:00.000000','yyyy/mm/dd hh24:mi:ss.ff'),
                            repeat_interval     => 'FREQ=MINUTELY; INTERVAL=5;',
                            end_date            => NULL,
                            job_class           => 'DEFAULT_JOB_CLASS',
                            enabled             => TRUE,
                            comments            => 'Відправка централізованих зп договорів на регіони');
exception when others then
      if (sqlcode = -27477) then null;
        else raise; 
      end if;
end;
/


