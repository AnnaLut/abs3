set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !$V
prompt Наименование операции: !$V STOP правило для облігацій заповнення доп реквізитів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!$V', '!$V STOP правило для облігацій заповнення доп реквізитів', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_stop(80840,#(ref),'''',0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!$V', name='!$V STOP правило для облігацій заповнення доп реквізитів', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_stop(80840,#(ref),'''',0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!$V';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!$V';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!$V';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!$V';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!$V';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!$V';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!$V';
end;
/
prompt Создание / Обновление операции $09
prompt Наименование операции: $09 4.9.Погаш.Ном+Ост.Купону:кiлькiсть
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('$09', '$09 4.9.Погаш.Ном+Ост.Купону:кiлькiсть', 1, '#(f_dop(#(REF), ''O9819''))', 980, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', 980, null, null, null, null, 0, 0, 0, 0, ' #(S_KIL) *100', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='$09', name='$09 4.9.Погаш.Ном+Ост.Купону:кiлькiсть', dk=1, nlsm='#(f_dop(#(REF), ''O9819''))', kv=980, nlsk='#(branch_usr.get_branch_param2(''NLS_9910'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=' #(S_KIL) *100', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='$09';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='$09';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='$09';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='$09';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='$09';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='$09';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='$09';
end;
/
prompt Создание / Обновление операции $VZ
prompt Наименование операции: Військоий збір від погашення купону
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('$VZ', 'Військоий збір від погашення купону', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0)) ', 980, '#(get_nls_tt(''$VZ'',''NLSK''))', 980, null, null, null, null, 0, 0, 0, 0, 'round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', 'round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', 12, null, '0', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='$VZ', name='Військоий збір від погашення купону', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0)) ', kv=980, nlsk='#(get_nls_tt(''$VZ'',''NLSK''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', s2='round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', sk=12, proc=null, s3800='0', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='$VZ';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='$VZ';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='$VZ';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='$VZ';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='$VZ';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='$VZ';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='$VZ';
end;
/
prompt Создание / Обновление операции $00
prompt Наименование операции: $00 4.2.Погаш.Ном+Ост.Купону
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('$00', '$00 4.2.Погаш.Ном+Ост.Купону', 0, '#(bpk_get_transit(''10'',#(NLSB),#(NLSA),#(KVA)))', null, null, null, null, null, null, null, 1, 0, 0, 0, '#(S_NOM) * #(S_KIL)', null, null, null, null, null, '0000000000000001100000000001000000010000000000000000000000000000', 'Погаш.ном+ост.купону сертифiкатiв казначейських зобов`язань у фiзичних осiб:кiлькiсть #(S_KIL) шт.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='$00', name='$00 4.2.Погаш.Ном+Ост.Купону', dk=0, nlsm='#(bpk_get_transit(''10'',#(NLSB),#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s='#(S_NOM) * #(S_KIL)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000001100000000001000000010000000000000000000000000000', nazn='Погаш.ном+ост.купону сертифiкатiв казначейських зобов`язань у фiзичних осiб:кiлькiсть #(S_KIL) шт.'
       where tt='$00';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='$00';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '$00', 'O', 1, 10, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ADRES'', ''$00'', ''O'', 1, 10, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '$00', 'O', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ATRT '', ''$00'', ''O'', 1, 8, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '$00', 'O', 1, 15, '347', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#73 '', ''$00'', ''O'', 1, 15, ''347'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '$00', 'O', 1, 11, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DT_R '', ''$00'', ''O'', 1, 11, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '$00', 'O', 1, 4, 'Фізична особа', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''$00'', ''O'', 1, 4, ''Фізична особа'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KODCP', '$00', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KODCP'', ''$00'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '$00', 'O', 1, 100, '6', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_B'', ''$00'', ''O'', 1, 100, ''6'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '$00', 'O', 1, 101, '804', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''$00'', ''O'', 1, 101, ''804'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '$00', 'O', 1, 102, '8446023', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''$00'', ''O'', 1, 102, ''8446023'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NATIO', '$00', 'O', 1, 13, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''NATIO'', ''$00'', ''O'', 1, 13, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('O9819', '$00', 'O', 1, 99, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''O9819'', ''$00'', ''O'', 1, 99, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '$00', 'O', 1, 5, 'Паспорт', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP '', ''$00'', ''O'', 1, 5, ''Паспорт'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP2', '$00', 'O', 1, 9, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP2'', ''$00'', ''O'', 1, 9, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '$00', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''$00'', ''O'', 1, 7, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPS', '$00', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPS'', ''$00'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', '$00', 'O', 1, 14, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''POKPO'', ''$00'', ''O'', 1, 14, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('REZID', '$00', 'O', 1, 12, '1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''REZID'', ''$00'', ''O'', 1, 12, ''1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_KIL', '$00', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_KIL'', ''$00'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_KUT', '$00', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_KUT'', ''$00'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_NOM', '$00', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''S_NOM'', ''$00'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='$00';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!$V', '$00', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!$V'', ''$00'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('$09', '$00', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''$09'', ''$00'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('$VZ', '$00', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''$VZ'', ''$00'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='$00';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='$00';
  begin
    insert into tts_vob(vob, tt, ord)
    values (49, '$00', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 49, ''$00'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (220, '$00', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 220, ''$00'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='$00';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '$00', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''$00'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '$00', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''$00'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='$00';
end;
/
commit;
