declare
l_kf char(6);
begin
   for k in (select * from  mv_kf)
   LOOP
      bc.go(k.kf);
      begin
         l_kf    := sys_context('bars_context','user_mfo');
         BEGIN
            SYS.DBMS_SCHEDULER.DROP_JOB (job_name  => 'CR_351_'|| l_kf);
         exception when others then  if sqlcode = -27475 then null; else raise; end if;
         end;    
         EXECUTE IMMEDIATE  'begin
                             BARS.bars_login.set_long_session;
                             end;';
         SYS.DBMS_SCHEDULER.CREATE_JOB
          (job_name         => 'CR_351_'|| l_kf,
           job_type         => 'PLSQL_BLOCK',
           job_action       => 'declare 
                                 dat_   DATE   :=  TRUNC(add_months( sysdate, 1 ),''MM''); 
                                 l_c    integer;     
                                begin
                                   bars_login.login_user(sys_guid(),'||gl.aUid||', null, null); gl.param; 
                                   bc.go(' || l_kf || '); 
                                   delete from rez_log_18 where kf = ' ||l_kf|| ' and dat01 <> dat_; commit;
                                   begin
                                      select nvl(decode (nvl(c1,0), 1, 1) + decode (nvl(c2,0), 1, 1) + decode (nvl(c3,0), 1, 1),0) into l_c from rez_log_18 where kf = ' ||l_kf|| ' and dat01 = dat_;
                                   EXCEPTION WHEN NO_DATA_FOUND THEN l_c := 0;
                                   end;
                                   if l_c < 1 THEN Z23.START_REZ(dat_,0); p_2401(dat_); Z23.Set_OK_18 (dat_, ' ||l_kf|| ',  1 ); commit; end if;
                                   if l_c < 2 THEN Z23.ZALOG(dat_);                     Z23.Set_OK_18 (dat_, ' ||l_kf|| ',  2 ); commit; end if;
                                   if l_c < 3 THEN CR(dat_);                            Z23.Set_OK_18 (dat_, ' ||l_kf|| ',  3 ); commit; end if;
                                end;',
           enabled         => true,
           repeat_interval => 'FREQ=MONTHLY;BYMONTHDAY=18;BYHOUR=01;BYMINUTE=00;BYSECOND=0',
           comments => 'CR: Розрахунок кредитного ризику _ 351' 
          );
      END;
   end LOOP;
   bc.home;
end;
/
   
