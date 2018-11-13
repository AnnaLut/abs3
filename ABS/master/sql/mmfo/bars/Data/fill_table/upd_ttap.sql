PROMPT ------==== start upd_ttap.sql ====--------
PROMPT    --------------------------------
PROMPT    ------ Связанные операции ------
PROMPT    --------------------------------

begin
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!P', 'DP2', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('Не удалось добавить запись - первичный ключ не найден!');
        else raise;
        end if;
    end;

    commit;
end;
/
begin
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!P', '013', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('Не удалось добавить запись - первичный ключ не найден!');
        else raise;
        end if;
    end;

    commit;
end;
/
begin
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!P', '215', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('Не удалось добавить запись - первичный ключ не найден!');
        else raise;
        end if;
    end;

    commit;
end;
/
begin
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!P', '015', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('Не удалось добавить запись - первичный ключ не найден!');
        else raise;
        end if;
    end;

    commit;
end;
/
begin
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!P', '515', 0);
    exception
      when dup_val_on_index then null;
      when others then 
        if ( sqlcode = -02291 ) then
          dbms_output.put_line('Не удалось добавить запись - первичный ключ не найден!');
        else raise;
        end if;
    end;

    commit; 
end;
/

PROMPT ------==== finish upd_ttap.sql ====--------