set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 515
prompt Наименование операции: 515  Внутрiшнiй  MемOрдер 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('515', '515  Внутрiшнiй  MемOрдер ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0001100000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='515', name='515  Внутрiшнiй  MемOрдер ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='515';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='515';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#39 ', '515', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#39 '', ''515'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '515', 'O', 1, 1, '''  ''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''515'', ''O'', 1, 1, ''''''  '''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KURS ', '515', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KURS '', ''515'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='515';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='515';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='515';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '515', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''515'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='515';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '515', 2, null, '(visa_asvo(userid)=1 AND nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0) or (substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''515'', 2, null, ''(visa_asvo(userid)=1 AND nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0) or (substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '515', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''515'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (10, '515', 6, null, 'substr(nlsa,1,4) in (''3510'',''3610'')', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 10, ''515'', 6, null, ''substr(nlsa,1,4) in (''''3510'''',''''3610'''')'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, '515', 5, null, 'substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''515'', 5, null, ''substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='515';
  begin
    insert into folders_tts(idfo, tt)
    values (40, '515');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 40, ''515'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
