set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!D
prompt Наименование операции: STOP правило на поповн деп за період
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!D', 'STOP правило на поповн деп за період', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(''1478'',#(KVA),#(NLSB),#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!D', name='STOP правило на поповн деп за період', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(''1478'',#(KVA),#(NLSB),#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!D';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='!!D';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!D';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!D';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='!!D';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!D';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='!!D';
  
  
end;
/

prompt Создание / Обновление операции 015
prompt Наименование операции: 015-Внутрiшнiй MемOрдер (грн)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('015', '015-Внутрiшнiй MемOрдер (грн)', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1101100000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='015', name='015-Внутрiшнiй MемOрдер (грн)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1101100000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='015';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='015';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#39 ', '015', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#39 '', ''015'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#44 ', '015', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#44 '', ''015'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '015', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#73 '', ''015'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '015', 'O', 1, 1, '''  ''', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''015'', ''O'', 1, 1, ''''''  '''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '015', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_B'', ''015'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '015', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''015'', ''O'', 1, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '015', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''015'', ''O'', 1, 5, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('n    ', '015', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''n    '', ''015'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='015';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!D', '015', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!!D'', ''015'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='015';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='015';
  begin
    insert into tts_vob(vob, tt)
    values (6, '015');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''015'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='015';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '015', 2, null, '(nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0 or (substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)))', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''015'', 2, null, ''(nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0 or (substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '015', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''015'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (10, '015', 4, null, 'substr(nlsa,1,4) in (''3510'',''3610'')', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 10, ''015'', 4, null, ''substr(nlsa,1,4) in (''''3510'''',''''3610'''')'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, '015', 3, null, 'substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''015'', 3, null, ''substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='015';
  begin
    insert into folders_tts(idfo, tt)
    values (26, '015');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''015'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (92, '015');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 92, ''015'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
