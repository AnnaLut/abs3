set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ЦП2
prompt Наименование операции: ЦП2 ДЦП - зовнішні
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ЦП2', 'ЦП2 ДЦП - зовнішні', 1, null, 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ЦП2', name='ЦП2 ДЦП - зовнішні', dk=1, nlsm=null, kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ЦП2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ЦП2';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('П    ', 'ЦП2', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''П    '', ''ЦП2'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ЦП2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ЦП2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ЦП2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'ЦП2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''ЦП2'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ЦП2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'ЦП2', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''ЦП2'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'ЦП2', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''ЦП2'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (39, 'ЦП2', 6, null, '(NLSA NOT LIKE ''2%'' AND((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000)))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 39, ''ЦП2'', 6, null, ''(NLSA NOT LIKE ''''2%'''' AND((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000)))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (40, 'ЦП2', 7, null, '(NLSA NOT LIKE ''2%'' AND((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000)))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 40, ''ЦП2'', 7, null, ''(NLSA NOT LIKE ''''2%'''' AND((KV=980 AND S>30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)>30000000000)))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (41, 'ЦП2', 4, null, '(NLSA NOT LIKE ''2%'' AND((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 41, ''ЦП2'', 4, null, ''(NLSA NOT LIKE ''''2%'''' AND((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (42, 'ЦП2', 5, null, '(NLSA NOT LIKE ''2%'' AND((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 42, ''ЦП2'', 5, null, ''(NLSA NOT LIKE ''''2%'''' AND((KV=980 AND S<=30000000000) OR (KV<>980 AND GL.P_ICURVAL(KV,S,BANKDATE)<=30000000000)))'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (62, 'ЦП2', 3, null, 'mfoa=300465 and nlsa like ''26%''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 62, ''ЦП2'', 3, null, ''mfoa=300465 and nlsa like ''''26%'''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ЦП2';
end;
/
commit;
