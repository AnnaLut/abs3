set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции TO4
prompt Наименование операции: TO4 Коригування загрузки / вигрузки банкоматів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TO4', 'TO4 Коригування загрузки / вигрузки банкоматів', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, 66, null, null, null, '1000100001000000000000000000000000010000000000000000000000000000', 'Коригування загрузки / вигрузки банкоматів');
  exception
    when dup_val_on_index then 
      update tts
         set tt='TO4', name='TO4 Коригування загрузки / вигрузки банкоматів', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=66, proc=null, s3800=null, rang=null, flags='1000100001000000000000000000000000010000000000000000000000000000', nazn='Коригування загрузки / вигрузки банкоматів'
       where tt='TO4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='TO4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='TO4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='TO4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='TO4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='TO4';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'TO4', 4, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''TO4'', 4, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'TO4', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''TO4'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='TO4';
end;
/
commit;
