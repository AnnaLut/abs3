-- 2). Добавл. допустимых балансовых в операции 101,D66


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('3739', '101', 1, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3739'', ''101'', 1, null) - первичный ключ не найден!');
    else raise;
    end if;
end;
/


begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('2902', 'D66', 0, null);
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2902'', ''D66'', 0, null) - первичный ключ не найден!');
    else raise;
    end if;
end;
/


commit;



