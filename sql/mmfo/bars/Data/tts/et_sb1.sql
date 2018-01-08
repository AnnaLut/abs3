set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SB9
prompt Наименование операции: SB9 Списання з позаб. оприбутк.цінностей банкнот після досл. від НБУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SB9', 'SB9 Списання з позаб. оприбутк.цінностей банкнот після досл. від НБУ', 1, '#(nbs_ob22 (''9899'',''C4''))', null, '#(nbs_ob22 (''9910'',''01''))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SB9', name='SB9 Списання з позаб. оприбутк.цінностей банкнот після досл. від НБУ', dk=1, nlsm='#(nbs_ob22 (''9899'',''C4''))', kv=null, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='SB9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SB9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SB9';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SB9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SB9';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SB9';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SB9';
end;
/
prompt Создание / Обновление операции SB1
prompt Наименование операции: SB1  Оприбутк. в сховищі цінностей банкнот, отрим. після досл. від НБУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SB1', 'SB1  Оприбутк. в сховищі цінностей банкнот, отрим. після досл. від НБУ', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASHS'',0))', null, '#(nbs_ob22 (''2909'',''34''))', null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASHS'',0))', '#(nbs_ob22 (''2909'',''34''))', null, 1, 0, 0, 0, null, null, 32, null, null, null, '1000100001000000000000000000000000010000000000000000000000000000', 'Оприбуткування в сховищі цінностей банкнот, отриманих після дослідження від НБУ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SB1', name='SB1  Оприбутк. в сховищі цінностей банкнот, отрим. після досл. від НБУ', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASHS'',0))', kv=null, nlsk='#(nbs_ob22 (''2909'',''34''))', kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASHS'',0))', nlsb='#(nbs_ob22 (''2909'',''34''))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=32, proc=null, s3800=null, rang=null, flags='1000100001000000000000000000000000010000000000000000000000000000', nazn='Оприбуткування в сховищі цінностей банкнот, отриманих після дослідження від НБУ'
       where tt='SB1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SB1';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'SB1', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''SB1'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('INK_K', 'SB1', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''INK_K'', ''SB1'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OSOBA', 'SB1', 'O', 0, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OSOBA'', ''SB1'', ''O'', 0, 7, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', 'SB1', 'O', 1, 2, 'Паспорт', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP '', ''SB1'', ''O'', 1, 2, ''Паспорт'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'SB1', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''SB1'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PIDST', 'SB1', 'O', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PIDST'', ''SB1'', ''O'', 1, 8, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('VA_KK', 'SB1', 'O', 1, 11, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''VA_KK'', ''SB1'', ''O'', 1, 11, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('VA_NC', 'SB1', 'O', 1, 10, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''VA_NC'', ''SB1'', ''O'', 1, 10, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SB1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('SB9', 'SB1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''SB9'', ''SB1'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SB1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', 'SB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''SB1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'SB1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''SB1'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SB1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (986, 'SB1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 986, ''SB1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SB1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'SB1', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''SB1'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SB1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''SB1'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SB1';
  begin
    insert into folders_tts(idfo, tt)
    values (16, 'SB1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 16, ''SB1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
