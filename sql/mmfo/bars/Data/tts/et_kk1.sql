set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KKS
prompt Наименование операции: KKS --KKS/КП. STOP-правило на перебільшення ЛІМІТа
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KKS', 'KKS --KKS/КП. STOP-правило на перебільшення ЛІМІТа', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'STOP_KK ( #(REF) )', null, null, null, null, null, '0000100000000000000000000000000000000000000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KKS', name='KKS --KKS/КП. STOP-правило на перебільшення ЛІМІТа', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='STOP_KK ( #(REF) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000100000000000000000', nazn=null
       where tt='KKS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KKS';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KKS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KKS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KKS';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KKS';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KKS';
  begin
    insert into folders_tts(idfo, tt)
    values (7, 'KKS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 7, ''KKS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции KKW
prompt Наименование операции: KKW - видача кредиту на ПК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KKW', 'KKW - видача кредиту на ПК', null, '#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))', null, '#(cck_dop.get_kkw_crd(#(REF)))', null, null, null, null, null, 0, 0, 0, 0, 'cck_dop.get_amount_kkw(#(ref))', null, null, null, '0', null, '0001100000000000000000000001000000010000000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KKW', name='KKW - видача кредиту на ПК', dk=null, nlsm='#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))', kv=null, nlsk='#(cck_dop.get_kkw_crd(#(REF)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='cck_dop.get_amount_kkw(#(REF))', s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0001100000000000000000000001000000010000000000100000000000000000', nazn=null
       where tt='KKW';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KKW';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KKW';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KKW';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KKW';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KKW';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KKW';
end;
/
prompt Создание / Обновление операции KK1
prompt Наименование операции: KK1 --KK1/КП. Внутрішнє для Кредитів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KK1', 'KK1 --KK1/КП. Внутрішнє для Кредитів', 1, null, null, '#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))', null, null, null, null, null, 1, 0, 0, 0, null, null, 61, null, '0', null, '0001100000000000000000000001000000010000000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KK1', name='KK1 --KK1/КП. Внутрішнє для Кредитів', dk=1, nlsm=null, kv=null, nlsk='#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=61, proc=null, s3800='0', rang=null, flags='0001100000000000000000000001000000010000000000100000000000000000', nazn=null
       where tt='KK1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KK1';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', 'KK1', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ADRES'', ''KK1'', ''O'', 1, 5, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'KK1', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ATRT '', ''KK1'', ''O'', 1, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', 'KK1', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DT_R '', ''KK1'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'KK1', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''KK1'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('MDATE', 'KK1', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''MDATE'', ''KK1'', ''O'', 1, 7, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', 'KK1', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP '', ''KK1'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'KK1', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''KK1'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KK1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KKS', 'KK1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''KKS'', ''KK1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KKW', 'KK1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''KKW'', ''KK1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KK1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KK1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'KK1', 6);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''KK1'', 6) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KK1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''KK1'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (46, 'KK1', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 46, ''KK1'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (124, 'KK1', 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 124, ''KK1'', 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KK1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'KK1', 4, null, 'substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''KK1'', 4, null, ''substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, 'KK1', 2, null, '(KV<>980 AND substr(nlsA,1,4) in (''2062'',''2063'',''2082'',''2083'',''2102'',''2103'',''2122'',''2123'',''2112'',''2113'',''2132'',''2133'') AND (substr(nlsB,1,2) in (''25'',''26'') OR substr(nlsB,1,4) in (''1919'',''3739'',''2909'')))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 7, ''KK1'', 2, null, ''(KV<>980 AND substr(nlsA,1,4) in (''''2062'''',''''2063'''',''''2082'''',''''2083'''',''''2102'''',''''2103'''',''''2122'''',''''2123'''',''''2112'''',''''2113'''',''''2132'''',''''2133'''') AND (substr(nlsB,1,2) in (''''25'''',''''26'''') OR substr(nlsB,1,4) in (''''1919'''',''''3739'''',''''2909'''')))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'KK1', 3, null, 'substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''KK1'', 3, null, ''substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'KK1', 9, null, 'bpk_visa30(ref, 1)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''KK1'', 9, null, ''bpk_visa30(ref, 1)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KK1';
  begin
    insert into folders_tts(idfo, tt)
    values (7, 'KK1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 7, ''KK1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
