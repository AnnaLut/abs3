set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DP!
prompt Наименование операции: DP! +D: STOP-правило на поповнення вкладу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DP!', 'DP! +D: STOP-правило на поповнення вкладу', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, '0', null, null, null, null, 0, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DP!', name='DP! +D: STOP-правило на поповнення вкладу', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DP!';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DP!';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DP!';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DP!';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DP!';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DP!';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DP!';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DP!');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''DP!'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции KB8
prompt Наименование операции: KB8 off DPT - Списання з транзиту на основн. рахунок деп. вкладу в ТВБ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KB8', 'KB8 off DPT - Списання з транзиту на основн. рахунок деп. вкладу в ТВБ', 1, '#(tobopack.GetTOBOParam(''TRDPT''))', null, '#(bars_xmlklb_dpt.main_nls)', null, null, '#(tobopack.GetTOBOParam(''TRDPT''))', '#(bars_xmlklb_dpt.main_nls()))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0001100000000000000000000000000000010000000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KB8', name='KB8 off DPT - Списання з транзиту на основн. рахунок деп. вкладу в ТВБ', dk=1, nlsm='#(tobopack.GetTOBOParam(''TRDPT''))', kv=null, nlsk='#(bars_xmlklb_dpt.main_nls)', kvk=null, nlss=null, nlsa='#(tobopack.GetTOBOParam(''TRDPT''))', nlsb='#(bars_xmlklb_dpt.main_nls()))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000000000000000000000000000010000000000100000000000000000', nazn=null
       where tt='KB8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KB8';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CNTR ', 'KB8', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CNTR '', ''KB8'', ''M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOF', 'KB8', 'O', 0, null, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOF'', ''KB8'', ''O'', 0, null, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'KB8', 'O', 0, null, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''KB8'', ''O'', 0, null, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTPR', 'KB8', 'M', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTPR'', ''KB8'', ''M'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ISOFF', 'KB8', 'O', 0, null, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ISOFF'', ''KB8'', ''O'', 0, null, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KB8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KB8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KB8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KB8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'KB8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''KB8'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KB8';
end;
/
prompt Создание / Обновление операции KBD
prompt Наименование операции: KBD off DPT - Поповнення вкладу з поточ. рахунку
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KBD', 'KBD off DPT - Поповнення вкладу з поточ. рахунку', 0, '#(tobopack.GetTOBOParam(''TRDPT''))', null, null, null, null, '#(tobopack.GetTOBOParam(''TRDPT''))', null, null, 0, 0, 0, 0, null, null, 16, null, null, null, '0001100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KBD', name='KBD off DPT - Поповнення вкладу з поточ. рахунку', dk=0, nlsm='#(tobopack.GetTOBOParam(''TRDPT''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa='#(tobopack.GetTOBOParam(''TRDPT''))', nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=16, proc=null, s3800=null, rang=null, flags='0001100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='KBD';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KBD';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CNTR ', 'KBD', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CNTR '', ''KBD'', ''M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTCH', 'KBD', 'O', 0, null, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTCH'', ''KBD'', ''O'', 0, null, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOF', 'KBD', 'O', 0, null, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOF'', ''KBD'', ''O'', 0, null, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'KBD', 'O', 0, null, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''KBD'', ''O'', 0, null, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTPR', 'KBD', 'M', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTPR'', ''KBD'', ''M'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ISOFF', 'KBD', 'O', 0, null, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ISOFF'', ''KBD'', ''O'', 0, null, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KBD';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DP!', 'KBD', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''DP!'', ''KBD'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KB8', 'KBD', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''KB8'', ''KBD'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KBD';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'KBD', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''26  '', ''KBD'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KBD';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KBD', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''KBD'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KBD';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'KBD', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''KBD'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KBD';
end;
/
commit;
