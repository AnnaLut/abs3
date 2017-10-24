set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции FX9
prompt Наименование операции: FX9-ФОРВАРД (внебаланс)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FX9', 'FX9-ФОРВАРД (внебаланс)', 1, '920231', null, '921201', null, null, '920231', '921201', null, 1, 0, 0, 0, null, null, null, null, null, null, '1100000000000000000000000000000000000000000000000100000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FX9', name='FX9-ФОРВАРД (внебаланс)', dk=1, nlsm='920231', kv=null, nlsk='921201', kvk=null, nlss=null, nlsa='920231', nlsb='921201', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100000000000000000000000000000000000000000000000100000000000000', nazn=null
       where tt='FX9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='FX9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='FX9';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('FX9', 'FX9', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''FX9'', ''FX9'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='FX9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='FX9';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'FX9', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''FX9'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='FX9';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'FX9', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''FX9'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (75, 'FX9', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 75, ''FX9'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='FX9';
  begin
    insert into folders_tts(idfo, tt)
    values (71, 'FX9');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 71, ''FX9'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции FX9
prompt Наименование операции: FX9-ФОРВАРД (внебаланс)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FX9', 'FX9-ФОРВАРД (внебаланс)', 1, '920231', null, '921201', null, null, '920231', '921201', null, 1, 0, 0, 0, null, null, null, null, null, null, '1100000000000000000000000000000000000000000000000100000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FX9', name='FX9-ФОРВАРД (внебаланс)', dk=1, nlsm='920231', kv=null, nlsk='921201', kvk=null, nlss=null, nlsa='920231', nlsb='921201', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100000000000000000000000000000000000000000000000100000000000000', nazn=null
       where tt='FX9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='FX9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='FX9';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('FX9', 'FX9', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''FX9'', ''FX9'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='FX9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='FX9';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'FX9', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''FX9'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='FX9';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'FX9', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''FX9'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (75, 'FX9', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 75, ''FX9'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='FX9';
  begin
    insert into folders_tts(idfo, tt)
    values (71, 'FX9');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 71, ''FX9'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
