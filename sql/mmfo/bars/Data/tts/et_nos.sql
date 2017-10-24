set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции NOS
prompt Наименование операции: NOS - Загр.перев после подбора НОСТРО-сч (доп рекв)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('NOS', 'NOS - Загр.перев после подбора НОСТРО-сч (доп рекв)', 1, '191992', null, null, null, null, null, null, '300465', 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='NOS', name='NOS - Загр.перев после подбора НОСТРО-сч (доп рекв)', dk=1, nlsm='191992', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='NOS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='NOS';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D1#E2', 'NOS', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D1#E2'', ''NOS'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D2#70', 'NOS', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D2#70'', ''NOS'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D3#70', 'NOS', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D3#70'', ''NOS'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D4#70', 'NOS', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D4#70'', ''NOS'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D6#70', 'NOS', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D6#70'', ''NOS'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DB#70', 'NOS', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DB#70'', ''NOS'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DC#70', 'NOS', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DC#70'', ''NOS'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DE#E2', 'NOS', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DE#E2'', ''NOS'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='NOS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='NOS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='NOS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'NOS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''NOS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='NOS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'NOS', 1, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''NOS'', 1, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (39, 'NOS', 6, null, '((KV=980 AND S >30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE) >30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''NOS_T'' and value in (''FX4'',''WD3'',''V07'',''8C4'',''SW4'',''V77'',''KV3''))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 39, ''NOS'', 6, null, ''((KV=980 AND S >30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE) >30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''''NOS_T'''' and value in (''''FX4'''',''''WD3'''',''''V07'''',''''8C4'''',''''SW4'''',''''V77'''',''''KV3''''))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (40, 'NOS', 7, null, '((KV=980 AND S >30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE) >30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''NOS_T'' and value in (''FX4'',''WD3'',''V07'',''8C4'',''SW4'',''V77'',''KV3''))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 40, ''NOS'', 7, null, ''((KV=980 AND S >30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE) >30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''''NOS_T'''' and value in (''''FX4'''',''''WD3'''',''''V07'''',''''8C4'''',''''SW4'''',''''V77'''',''''KV3''''))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (41, 'NOS', 4, null, '((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''NOS_T'' and value in (''FX4'',''WD3'',''V07'',''8C4'',''SW4'',''V77'',''KV3''))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 41, ''NOS'', 4, null, ''((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''''NOS_T'''' and value in (''''FX4'''',''''WD3'''',''''V07'''',''''8C4'''',''''SW4'''',''''V77'''',''''KV3''''))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (42, 'NOS', 5, null, '((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''NOS_T'' and value in (''FX4'',''WD3'',''V07'',''8C4'',''SW4'',''KV3''))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 42, ''NOS'', 5, null, ''((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)) and exists (select 1 from operw where ref = o.ref and tag = ''''NOS_T'''' and value in (''''FX4'''',''''WD3'''',''''V07'''',''''8C4'''',''''SW4'''',''''KV3''''))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (50, 'NOS', 8, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 50, ''NOS'', 8, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (71, 'NOS', 9, null, '((substr(nlsB,1,4)<>''1600'') or (substr(nlsB,1,4)=''1600'' and MFOA=''300465''))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 71, ''NOS'', 9, null, ''((substr(nlsB,1,4)<>''''1600'''') or (substr(nlsB,1,4)=''''1600'''' and MFOA=''''300465''''))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='NOS';
  begin
    insert into folders_tts(idfo, tt)
    values (72, 'NOS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 72, ''NOS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
