begin
   update params$global  set PAR = 'XOZ_NEW', VAL = 0, COMM = 'Новий модуль господарської дебіторки', SRV_FLAG = 0
   where  PAR = 'XOZ_NEW';
   IF SQL%ROWCOUNT=0 then
      insert into params$global ( PAR, VAL, COMM, SRV_FLAG) values ('XOZ_NEW', 0, 'Новий модуль господарської дебіторки',0 );
   END IF;
   commit;
end;                                                     
/

begin
   for k in (select * from mv_kf)
   LOOP
      bc.go(k.kf);
      update rez_log set fdat=to_date('02-09-2017','dd-mm-yyyy') where fdat = to_date('01-09-2017','dd-mm-yyyy') and txt like 'Конец Кол-во дней прострочки (дебиторка) 351%';
   end loop;
   commit;
   bc.go('/');
end;
/
