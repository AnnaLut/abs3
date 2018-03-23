--
begin
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'PKD', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'DPI', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'DP2', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'OW4', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'PK!', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', '013', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'R01', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', '215', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', '015', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', '515', 0);
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
    --------------------------------
    ------ Связанные операции ------
    --------------------------------
    begin
      insert into ttsap(ttap, tt, dk)
      values ('!!D', 'OW5', 0);
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
