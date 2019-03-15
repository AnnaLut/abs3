prompt Создание / Обновление операции 092
prompt Наименование операции: Збільшення запасів готівки за рахунок операційної каси
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('092', 'Збільшення запасів готівки за рахунок операційної каси', 1, null, null, null, null, null,'#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS1811'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))',null, 0, 0, 0, 0, null, null, 67, null, null, null, '1001100001000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='092', name='Збільшення запасів готівки за рахунок операційної каси', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS1811'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=67, proc=null, s3800=null, rang=null, flags='1001100001000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='092';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='092';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SAGON', '092', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D    '', ''092'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SAGOD', '092', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D    '', ''092'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SAGOU', '092', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D    '', ''092'', ''M'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;

  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='092';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1811', '092', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1811'', ''092'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', '092', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''092'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='092';
  begin
    insert into tts_vob(vob, tt, ord)
    values (56, '092', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 56, ''092'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='092';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '092', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''092'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='092';
  begin
    insert into folders_tts(idfo, tt)
    values (16, '092');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 16, ''092'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
