
----   Заявка COBUSUPABS-7570


----   D66:   + 3600/02 по Дт

begin
  insert into ps_tts(nbs, tt, dk, OB22)
  values ('3600', 'D66', 0, '02' );
exception when others then 
  null;
end;
/
commit;
