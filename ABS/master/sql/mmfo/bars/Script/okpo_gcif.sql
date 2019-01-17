declare 
  l_kf varchar2(6);
begin
   for m in (select kf from mv_kf)
   loop
      bc.go (m.kf);    
      l_kf      := sys_context('bars_context','user_mfo');
      BEGIN
         SYS.DBMS_SCHEDULER.DROP_JOB (job_name  => 'OKPO_ND_VAL_'|| l_kf);
      exception when others then  if sqlcode = -27475 then null; else raise; end if;
      end;    
      EXECUTE IMMEDIATE  'begin
                          BARS.bars_login.set_long_session;
                          end;';
      SYS.DBMS_SCHEDULER.CREATE_JOB
         (job_name         => 'OKPO_ND_VAL_'|| l_kf,
          job_type         => 'PLSQL_BLOCK',
          job_action       => 'declare 
                                 p_dat01 date     := to_date(''01-01-2019'',''dd-mm-yyyy'');
                               begin
                                  bc.go(' || l_kf || '); 
                                  for k in ( select * 
                                             from (select o.rowid ri,o.* , F_RNK_gcif ((select okpo from customer where rnk=o.rnk), o.rnk) f_okpo 
                                                   from   nd_val o 
                                                   where  fdat = p_dat01)
                                             where okpo<>f_okpo )
                                  Loop
                                     update nd_val set okpo = k.f_okpo where rowid = k.RI;
                                  end loop;
                                  commit;
                               end;',
          enabled         => true,
          --repeat_interval => 'FREQ=DAILY;BYDAY=SUN,MON,SAT,TUE,WED,THU,FRI;BYHOUR=12;BYMINUTE=58;BYSECOND=0',
          comments => 'Приведення OKPO_GCIF' 
         );
   end loop;
   bc.go('/');
END;
/

