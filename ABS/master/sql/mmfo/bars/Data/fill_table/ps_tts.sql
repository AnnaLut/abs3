begin
   insert into ps_tts(nbs, tt, dk)
   values ('2605', '100', 0 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2655', '100', 0 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2605', '101', 0 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2655', '101', 0 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2605', '100', 1 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2655', '100', 1 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2605', '101', 1 );
exception
   when dup_val_on_index then null;
end;
/

begin
   insert into ps_tts(nbs, tt, dk)
   values ('2655', '101', 1 );
exception
   when dup_val_on_index then null;
end;
/

commit;
