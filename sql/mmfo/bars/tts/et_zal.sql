set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ZAL
prompt Наименование операции: --ZAL/КП. Застава по кредитах
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ZAL', '--ZAL/КП. Застава по кредитах', 1, '9900107', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 10, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ZAL', name='--ZAL/КП. Застава по кредитах', dk=1, nlsm='9900107', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=10, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ZAL';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ZAL';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ZAL';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ZAL';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ZAL';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, 'ZAL', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 206, ''ZAL'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (207, 'ZAL', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 207, ''ZAL'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ZAL';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'ZAL', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''ZAL'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ZAL';
  begin
    insert into folders_tts(idfo, tt)
    values (7, 'ZAL');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 7, ''ZAL'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
