set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции %03
prompt Наименование операции: %03 Начисление % для ПФ нерезид по привлечению (10%)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%03', '%03 Начисление % для ПФ нерезид по привлечению (10%)', 1, null, null, '362030015', 980, null, null, null, null, 0, 0, 1, 0, '0.1 * #(S)', '0.1 *  gl.p_icurval ( #(KVA), #(S), bankdate )', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%03', name='%03 Начисление % для ПФ нерезид по привлечению (10%)', dk=1, nlsm=null, kv=null, nlsk='362030015', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='0.1 * #(S)', s2='0.1 *  gl.p_icurval ( #(KVA), #(S), bankdate )', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='%03';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='%03';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='%03';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='%03';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='%03';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='%03';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='%03';
end;
/
prompt Создание / Обновление операции %02
prompt Наименование операции: %02 Начисление % для нерезид по привлечению (100%)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%02', '%02 Начисление % для нерезид по привлечению (100%)', 1, null, null, null, null, null, null, null, null, 1, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%02', name='%02 Начисление % для нерезид по привлечению (100%)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='%02';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='%02';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='%02';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('%03', '%02', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''%03'', ''%02'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='%02';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='%02';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='%02';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '%02', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''%02'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '%02', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''%02'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='%02';
end;
/
commit;
