--Job STO_PM_AUTO_STORNO
  /*drop old job is exists*/
 begin
    dbms_scheduler.drop_job(job_name => 'BARS.STO_PM_AUTO_STORNO');
  exception when others then
    if sqlcode = -27475 then 
      null;
    elsif sqlcode = -27478 then -- is running
      dbms_scheduler.stop_job(job_name => 'BARS.STO_PM_AUTO_STORNO', force => true);
      dbms_scheduler.drop_job(job_name => 'BARS.STO_PM_AUTO_STORNO');
    else 
      raise; 
    end if;
 end;    
/ 
---create new-----
begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.STO_PM_AUTO_STORNO',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin
                                                         for i in (select kf from mv_kf) loop
                                                                 bc.go(i.kf);
                                                                 bars.sto_payment_utl.auto_storno;
                                                                 commit;
                                                           end loop;
                                                        end',
                                start_date          => to_date('01-01-2000 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Сторнування документів');
end;
/    
