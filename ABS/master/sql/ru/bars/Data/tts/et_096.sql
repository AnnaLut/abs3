set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !96
prompt Наименование операции: STOP-контроль(введеннЯ корегуючих)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!96', 'STOP-контроль(введеннЯ корегуючих)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_stop_zo(#(REF))', null, null, null, null, null, '0000100000000000000000000001000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!96', name='STOP-контроль(введеннЯ корегуючих)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_stop_zo(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000100000000000000000000000000', nazn=null
       where tt='!96';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!96';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!96';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!96';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!96';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!96';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!96';
end;
/
prompt Создание / Обновление операции 096
prompt Наименование операции: 096-Корегуючі за Місяць
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('096', '096-Корегуючі за Місяць', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22(''3800'',''03''))', null, '1001100000000000000000000000000000010000000000000000000000030000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='096', name='096-Корегуючі за Місяць', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22(''3800'',''03''))', rang=null, flags='1001100000000000000000000000000000010000000000000000000000030000', nazn=null
       where tt='096';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='096';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OB22 ', '096', 'O', 1, 0, '03', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OB22 '', ''096'', ''O'', 1, 0, ''03'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OB40 ', '096', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OB40 '', ''096'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OB40D', '096', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OB40D'', ''096'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TOBO3', '096', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TOBO3'', ''096'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='096';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!96', '096', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!96'', ''096'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='096';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='096';
  begin
    insert into tts_vob(vob, tt, ord)
    values (96, '096', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 96, ''096'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='096';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '096', 3, null, 'substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''096'', 3, null, ''substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '096', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''096'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, '096', 2, null, 'substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''096'', 2, null, ''substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='096';
  begin
    insert into folders_tts(idfo, tt)
    values (28, '096');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 28, ''096'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
