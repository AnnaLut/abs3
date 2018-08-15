
----  В операции  001, 002  добавляем бал. 2620/32 по Дт



begin
  bc.go('/');
  insert into ps_tts(nbs, tt, dk, OB22)
  values ('2620', '001', 0, '32' );
exception when others then 
  null;
end;
/


begin
  bc.go('/');
  insert into ps_tts(nbs, tt, dk, OB22)
  values ('2620', '002', 0, '32' );
exception when others then 
  null;
end;
/


commit;
