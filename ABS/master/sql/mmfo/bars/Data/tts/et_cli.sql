set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CLD
prompt Наименование операции: SWT->VPS Транзит на дирекції по Claims Conferens
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLD', 'SWT->VPS Транзит на дирекції по Claims Conferens', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, '#(S)+225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', 'Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLD', name='SWT->VPS Транзит на дирекції по Claims Conferens', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)+225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро'
       where tt='CLD';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLD';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLD';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLD';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLD';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLD';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLD';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLD');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 70, ''CLD'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции CLO
prompt Наименование операции: SWT->VPS Комісія Фонд Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLO', 'SWT->VPS Комісія Фонд Claims Conference', 1, '37397011', null, '19197202737', null, null, null, null, null, 0, 0, 0, 0, '225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLO', name='SWT->VPS Комісія Фонд Claims Conference', dk=1, nlsm='37397011', kv=null, nlsk='19197202737', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CLO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLO';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLO';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLO';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLO';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLO';
end;
/
prompt Создание / Обновление операции CLI
prompt Наименование операции: CLI-SWIFT->МВПС. Транзит c Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLI', 'CLI-SWIFT->МВПС. Транзит c Claims Conference', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '1200000000000000000000000000000000010300000000000000000000000000', 'Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLI', name='CLI-SWIFT->МВПС. Транзит c Claims Conference', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1200000000000000000000000000000000010300000000000000000000000000', nazn='Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро'
       where tt='CLI';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLI';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', 'CLI', 'M', 0, null, '840', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''CLI'', ''M'', 0, null, ''840'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', 'CLI', 'M', 0, null, '2867001', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''CLI'', ''M'', 0, null, ''2867001'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('n    ', 'CLI', 'M', 0, null, 'П840', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''n    '', ''CLI'', ''M'', 0, null, ''П840'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('П    ', 'CLI', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''П    '', ''CLI'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLI';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLD', 'CLI', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''CLD'', ''CLI'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLO', 'CLI', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''CLO'', ''CLI'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLI';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLI';
  begin
    insert into tts_vob(vob, tt, ord)
    values (74, 'CLI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 74, ''CLI'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLI';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CLI', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CLI'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CLI', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CLI'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLI';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLI');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 70, ''CLI'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
