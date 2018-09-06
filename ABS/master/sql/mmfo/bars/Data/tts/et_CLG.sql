set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CLK
prompt Наименование операции: SWT->ЦА Комісія Фонд Claims Conference(ЦА)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLK', 'SWT->ЦА Комісія Фонд Claims Conference(ЦА)', 1, '#(get_proc_nls(''T00'',#(KVA)))', null, '19197202737', null, null, null, null, null, 0, 0, 0, 0, '225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', 'Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLK', name='SWT->ЦА Комісія Фонд Claims Conference(ЦА)', dk=1, nlsm='#(get_proc_nls(''T00'',#(KVA)))', kv=null, nlsk='19197202737', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро'
       where tt='CLK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLK';
end;
/
prompt Создание / Обновление операции CLL
prompt Наименование операции: SWT->ЦА. Зарахування з Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLL', 'SWT->ЦА. Зарахування з Claims Conference', 1, '#(get_proc_nls(''T00'',#(KVA)))', null, '29090900056557', null, null, null, null, null, 0, 0, 0, 0, '#(S)-225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', 'Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLL', name='SWT->ЦА. Зарахування з Claims Conference', dk=1, nlsm='#(get_proc_nls(''T00'',#(KVA)))', kv=null, nlsk='29090900056557', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро'
       where tt='CLL';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLL';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLL';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLL';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLL';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLL';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLL';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLL');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 70, ''CLL'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции CLM
prompt Наименование операции: SWT->ЦА. Claims Conference(ЦА)-Внутрішня
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLM', 'SWT->ЦА. Claims Conference(ЦА)-Внутрішня', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', 'Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLM', name='SWT->ЦА. Claims Conference(ЦА)-Внутрішня', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро'
       where tt='CLM';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLM';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLM';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLM';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLM';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLM';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLM';
end;
/
prompt Создание / Обновление операции CLG
prompt Наименование операции: CLG-SWIFT->ЦА. Транзит c Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLG', 'CLG-SWIFT->ЦА. Транзит c Claims Conference', 1, null, 978, '#(get_proc_nls(''T00'',#(KVA)))', 978, null, null, '29090900056557', null, 1, 0, 0, 0, null, null, null, null, '0', null, '1000000000000000000000000000000000010300000000000000000000000000', 'Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLG', name='CLG-SWIFT->ЦА. Транзит c Claims Conference', dk=1, nlsm=null, kv=978, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=978, nlss=null, nlsa=null, nlsb='29090900056557', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='1000000000000000000000000000000000010300000000000000000000000000', nazn='Грошовий переказ з відрахуванням комісії банку-кор. CITI/London в сумі 2,25 Євро'
       where tt='CLG';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLG';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', 'CLG', 'M', 0, null, '840', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''CLG'', ''M'', 0, null, ''840'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', 'CLG', 'M', 0, null, '2867001', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''CLG'', ''M'', 0, null, ''2867001'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('n    ', 'CLG', 'M', 0, null, 'П840', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''n    '', ''CLG'', ''M'', 0, null, ''П840'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('П    ', 'CLG', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''П    '', ''CLG'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLG';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLK', 'CLG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''CLK'', ''CLG'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLL', 'CLG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''CLL'', ''CLG'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLM', 'CLG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''CLM'', ''CLG'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLG';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLG';
  begin
    insert into tts_vob(vob, tt, ord)
    values (74, 'CLG', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 74, ''CLG'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLG';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CLG', 2, null, null, 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CLG'', 2, null, null, 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CLG', 1, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CLG'', 1, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLG';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLG');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 70, ''CLG'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
