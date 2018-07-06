prompt ====================================
prompt Create job CIG_PVBKI_QUEUE_MMFO
prompt ====================================

begin

 BEGIN

 begin 
    sys.dbms_scheduler.create_job(  job_name        => 'BARS.CIG_PVBKI_QUEUE_MMFO',
                                    job_type        => 'PLSQL_BLOCK',
                                    job_action      => 'declare
  l_date date := sysdate;
begin
  for rec in (select t.kf from MV_KF t) loop
    bc.go(rec.kf);
    cig_mgr.collect_data(p_date => l_date, p_kf => rec.kf);
    commit;
    bc.home;
  end loop;
end;',
                                    start_date      => to_date('07-07-2018 12:23:35', 'dd-mm-yyyy hh24:mi:ss'),
                                    repeat_interval => 'Freq=Monthly;Interval=1;ByMonthDay=01;ByHour=00;ByMinute=01;BySecond=00',
                                    end_date        => to_date(null),
                                    job_class       => 'DEFAULT_JOB_CLASS',
                                    enabled         => TRUE,
                                    auto_drop       => false,
                                    comments        => 'Запускает последовательное формирование данных в разрезе МФО'); 
 end;   
     exception when others then
              if (sqlcode = -27477) then null;
              else raise; 
               end if;              
    end;
end;
/
