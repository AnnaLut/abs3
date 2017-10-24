prompt Restore PK! operation settings

begin
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    delete from ttsap where tt='PK!';
    begin
      insert into ttsap(ttap, tt, dk)
      values ('W45', 'PK!', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('Не удалось добавить запись (ttsap: ''W45'', ''PK!'', 0) - первичный ключ не найден!');
        else raise;
        end if;
    end;

    commit;
end;
/