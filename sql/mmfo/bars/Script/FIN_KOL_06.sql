declare 
  l_kf varchar2(6);
begin
   for m in (select kf from mv_kf)
   loop
      bc.go (m.kf);    
      l_kf      := sys_context('bars_context','user_mfo');
      BEGIN
         SYS.DBMS_SCHEDULER.DROP_JOB (job_name  => 'CR_351'|| l_kf);
      exception when others then  if sqlcode = -27475 then null; else raise; end if;
      end;    
      EXECUTE IMMEDIATE  'begin
                          BARS.bars_login.set_long_session;
                          end;';
      SYS.DBMS_SCHEDULER.CREATE_JOB
         (job_name         => 'CR_351_'|| l_kf,
          job_type         => 'PLSQL_BLOCK',
          job_action       => 'declare 
                                 p_dat01 date     := to_date(''01-06-2018'',''dd-mm-yyyy'');
                               begin
                                  bc.go(' || l_kf || '); 
                                  Z23.START_REZ(p_dat01,0);  
                                  commit;
                                  p_2401(p_dat01);   
                                  commit;
                                  Z23.ZALOG(p_dat01);  
                                  commit;
                                  CR(p_dat01);
                                  commit; 
                               end;',
          enabled         => true,
          --repeat_interval => 'FREQ=DAILY;BYDAY=SUN,MON,SAT,TUE,WED,THU,FRI;BYHOUR=12;BYMINUTE=58;BYSECOND=0',
          comments => 'Повний розрахунок резерву ' 
         );
   end loop;
END;
/

