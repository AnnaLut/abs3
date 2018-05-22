
-----------          Исправление по заявке COBUMMFO-6465 

---------  470  -----------------------------------------------------------------------------------------------------------------------------
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MIN', '470', 'O', 1, -2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_MIN'', ''470'', ''O'', 1, -2, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MAX', '470', 'O', 1, -1, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_MAX'', ''470'', ''O'', 1, -1, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

 ----------  471  -------------------------------------------------------------------------------------------------------------------------------

  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MIN', '471', 'O', 1, -2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_MIN'', ''471'', ''O'', 1, -2, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MAX', '471', 'O', 1, -1, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_MAX'', ''471'', ''O'', 1, -1, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

 ----------  472  -------------------------------------------------------------------------------------------------------------------------------

  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MIN', '472', 'O', 1, -2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_MIN'', ''472'', ''O'', 1, -2, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MAX', '472', 'O', 1, -1, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_MAX'', ''472'', ''O'', 1, -1, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

 -----------------------------------
 COMMIT;
