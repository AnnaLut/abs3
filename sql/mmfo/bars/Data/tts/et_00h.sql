set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !AA
prompt Наименование операции: !AA STOP-правило на продаж
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AA', '!AA STOP-правило на продаж', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(100,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AA', name='!AA STOP-правило на продаж', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(100,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='!AA';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!AA';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!AA';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!AA';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!AA';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!AA';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!AA';
end;
/
prompt Создание / Обновление операции !ZP
prompt Наименование операции: !ZP STOP-контроль (Зарплата)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!ZP', '!ZP STOP-контроль (Зарплата)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_ZP(#(REF))', null, null, null, '0', null, '0040M0000000000000000000040M000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!ZP', name='!ZP STOP-контроль (Зарплата)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_ZP(#(REF))', s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0040M0000000000000000000040M000000000000000000000000000000000000', nazn=null
       where tt='!ZP';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!ZP';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!ZP';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!ZP';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!ZP';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!ZP';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!ZP';
end;
/
prompt Создание / Обновление операции G0H
prompt Наименование операции: G0H Погаш.нарах.комiсiї за ЧЕК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0H', 'G0H Погаш.нарах.комiсiї за ЧЕК', 1, '#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0H', name='G0H Погаш.нарах.комiсiї за ЧЕК', dk=1, nlsm='#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G0H';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='G0H';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='G0H';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='G0H';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='G0H';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G0H';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='G0H';
end;
/
prompt Создание / Обновление операции K0H
prompt Наименование операции: K0H Нарах. 3570 комiсiї за ЧЕК 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0H', 'K0H Нарах. 3570 комiсiї за ЧЕК ', 1, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22 (''6510'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0H', name='K0H Нарах. 3570 комiсiї за ЧЕК ', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22 (''6510'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K0H';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K0H';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K0H';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K0H';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'K0H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''K0H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K0H';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K0H';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K0H';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K0H');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K0H'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции ЧЕ1
prompt Наименование операции: ЧЕ1 1) Доч. для чеків  (доч.к 00С)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ЧЕ1', 'ЧЕ1 1) Доч. для чеків  (доч.к 00С)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', 980, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', null, 0, 0, 0, 0, '100', '100', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ЧЕ1', name='ЧЕ1 1) Доч. для чеків  (доч.к 00С)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', kvk=980, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='100', s2='100', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ЧЕ1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ЧЕ1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ЧЕ1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ЧЕ1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ЧЕ1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ЧЕ1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ЧЕ1';
end;
/
prompt Создание / Обновление операции 00H
prompt Наименование операции: 00H-Видача вал. готiвки ЮО  (% комiс. змiнний)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('00H', '00H-Видача вал. готiвки ЮО  (% комiс. змiнний)', 1, null, null, null, null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000000000000010000000000000000000000000000', 'Видаток готівки по чеку');
  exception
    when dup_val_on_index then 
      update tts
         set tt='00H', name='00H-Видача вал. готiвки ЮО  (% комiс. змiнний)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000000000000010000000000000000000000000000', nazn='Видаток готівки по чеку'
       where tt='00H';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='00H';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '00H', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ADRES'', ''00H'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '00H', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ATRT '', ''00H'', ''O'', 1, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '00H', 'O', 1, null, '325', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#73 '', ''00H'', ''O'', 1, null, ''325'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '00H', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DT_R '', ''00H'', ''O'', 1, 5, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ED_VN', '00H', 'M', 1, 0, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ED_VN'', ''00H'', ''M'', 1, 0, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '00H', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''00H'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '00H', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_B'', ''00H'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '00H', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''00H'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '00H', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''00H'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NB758', '00H', 'M', 1, -2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''NB758'', ''00H'', ''M'', 1, -2, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OP758', '00H', 'O', 1, -1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OP758'', ''00H'', ''O'', 1, -1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '00H', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP '', ''00H'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '00H', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''00H'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PR068', '00H', 'M', 1, 0, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PR068'', ''00H'', ''M'', 1, 0, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='00H';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!AA', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!AA'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!ZP', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!ZP'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('G0H', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''G0H'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K0H', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K0H'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('ЧЕ1', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''ЧЕ1'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='00H';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', '00H', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''00H'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', '00H', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1002'', ''00H'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2560', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2560'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2604', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2604'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2650', '00H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2650'', ''00H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='00H';
  begin
    insert into tts_vob(vob, tt, ord)
    values (80, '00H', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 80, ''00H'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='00H';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '00H', 4, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''00H'', 4, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '00H', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''00H'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, '00H', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 7, ''00H'', 3, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, '00H', 2, null, 'check_visa11(REF)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''00H'', 2, null, ''check_visa11(REF)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='00H';
  begin
    insert into folders_tts(idfo, tt)
    values (91, '00H');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 91, ''00H'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
