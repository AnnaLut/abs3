declare 
p_dat  date := to_date('01-07-2018','dd-mm-yyyy');
l_kf   accounts.kf%type;
begin
   for k in ( select * from mv_kf )
   loop
      bc.go(k.kf); 
      l_kf   := sys_context('bars_context','user_mfo');
      BEGIN
         SYS.DBMS_SCHEDULER.DROP_JOB (job_name  => 'ZAL0107_'|| l_kf);
      exception when others then  if sqlcode = -27475 then null; else raise; end if;
      end;    
      SYS.DBMS_SCHEDULER.CREATE_JOB
          (job_name         => 'ZAL0107_'|| l_kf,
           job_type         => 'PLSQL_BLOCK',
           job_action       => 'declare 
                                   dat_   DATE   := TO_DATE('''||TO_CHAR(p_dat,'ddmmyyyy')||''',''ddmmyyyy'');
                                begin 
                                   bc.go(' || l_kf || '); 
                                   if sys_context(''bars_context'',''user_mfo'') in (''331467'',''323475'') THEN
                                      Z23.START_REZ(dat_,0);  
                                      p_2401(dat_);
                                      commit;
                                   end if;
                                   begin
                                      for cc in (select rowid RI from cc_accp 
                                                 where accs in (select acc from rez_cr where fdat = dat_
                                                   and tip in (''SDA'',''SDF'',''SDM'',''SDI'',''SRR'') )) 
                                      loop
                                         delete from cc_accp where rowid = cc.RI;
                                      end loop;	 
                                      commit;
                                   end;   
                                   Z23.ZALOG(dat_); 
                                end;',
           enabled         => true,
           --repeat_interval => 'FREQ=DAILY;BYDAY=SUN,MON,SAT,TUE,WED,THU,FRI;BYHOUR=12;BYMINUTE=58;BYSECOND=0',
           comments => 'ZAL: Перерасчет параметров и залогов ' 
          );
   end loop;
END;
/


