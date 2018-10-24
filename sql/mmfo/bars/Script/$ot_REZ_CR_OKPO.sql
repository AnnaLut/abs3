declare
l_kf char(6);
begin
   for k in (select * from  mv_kf  where kf='300465' )
   LOOP
      bc.go(k.kf);
      begin
         l_kf      := sys_context('bars_context','user_mfo');
         BEGIN
            SYS.DBMS_SCHEDULER.DROP_JOB (job_name  => 'REZ_CR_OKPO_'|| l_kf);
         exception when others then  if sqlcode = -27475 then null; else raise; end if;
         end;    
         EXECUTE IMMEDIATE  'begin
                             BARS.bars_login.set_long_session;
                             end;';
         SYS.DBMS_SCHEDULER.CREATE_JOB
          (job_name         => 'REZ_CR_OKPO_'|| l_kf,
           job_type         => 'PLSQL_BLOCK',
           job_action       => '
                                begin 
                                   bc.go(' || l_kf || '); 
                                   for k in (select r.rowid RI, c.okpo from rez_cr r, customer c where r.okpo is null and r.rnk=c.rnk)
                                   loop
                                      update rez_cr set okpo=k.okpo where rowid=k.Ri;
                                   end loop;
                                   commit;
                                end;',
           enabled         => true,
           -- repeat_interval => 'FREQ=MONTHLY;BYMONTHDAY=03;BYHOUR=13;BYMINUTE=30;BYSECOND=0',
           comments => 'REZ_CR_OKPO: Заполнение ОКПО в REZ_CR' 
          );
      END;
   end LOOP;
   bc.go('/');
end;
/

