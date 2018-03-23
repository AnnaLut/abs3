prompt Создание / Обновление операции PKR

begin
  insert into ps_tts(nbs, tt, dk, ob22)
  values ('2909', 'PKR', 0, '82');
exception
  when dup_val_on_index then null;
  when others then 
    if ( sqlcode = -02291 ) then
      dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''PKR'', 0, ''82'') - первичный ключ не найден!');
    else raise;
    end if;
end;
/
commit;
