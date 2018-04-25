begin
  dbms_scheduler.drop_job(job_name  => 'bars.zp_send_payrolls_result');
exception when others then
  if (sqlcode = -27475) then null;
  else raise; end if;
end;
/
 
begin
  dbms_scheduler.create_job(job_name        => 'bars.zp_send_payrolls_result',
                            job_type            => 'PLSQL_BLOCK',
                            job_action          => 'begin zp_corp2_intg.send_payrolls_result; end;',
                            number_of_arguments => 0,
                            start_date          => sysdate,
                            repeat_interval     => 'FREQ=MINUTELY; INTERVAL=5;',
                            end_date            => NULL,
                            job_class           => 'DEFAULT_JOB_CLASS',
                            enabled             => TRUE,
                            comments            => 'Відправка результатів обробки зарплатних відомостей і документів в корп2');
exception when others then
      if (sqlcode = -27477) then null;
        else raise; 
      end if;
end;
/


