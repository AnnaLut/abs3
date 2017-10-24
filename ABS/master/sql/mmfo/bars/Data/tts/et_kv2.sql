set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KV2
prompt Наименование операции: KV2-РАЗМЕЩЕНИЕ МБ (СЭП,ВПС)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KV2', 'KV2-РАЗМЕЩЕНИЕ МБ (СЭП,ВПС)', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0200000000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KV2', name='KV2-РАЗМЕЩЕНИЕ МБ (СЭП,ВПС)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0200000000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='KV2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KV2';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CP_IN', 'KV2', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CP_IN'', ''KV2'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('П    ', 'KV2', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''П    '', ''KV2'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KV2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KV2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KV2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'KV2', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''KV2'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KV2', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''KV2'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KV2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (39, 'KV2', 2, null, '((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 39, ''KV2'', 2, null, ''((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (40, 'KV2', 3, null, '((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 40, ''KV2'', 3, null, ''((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (41, 'KV2', 4, null, '((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 41, ''KV2'', 4, null, ''((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (42, 'KV2', 5, null, '((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 42, ''KV2'', 5, null, ''((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (75, 'KV2', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 75, ''KV2'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KV2';
  begin
    insert into folders_tts(idfo, tt)
    values (71, 'KV2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 71, ''KV2'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
