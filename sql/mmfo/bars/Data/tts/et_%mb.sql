set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции %MB
prompt Наименование операции: %MB Нарахування відсотків (кред.ресурси)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%MB', '%MB Нарахування відсотків (кред.ресурси)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%MB', name='%MB Нарахування відсотків (кред.ресурси)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000100000000000010000000000000', nazn=null
       where tt='%MB';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='%MB';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='%MB';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='%MB';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='%MB';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '%MB', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''%MB'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='%MB';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='%MB';
  begin
    insert into folders_tts(idfo, tt)
    values (1, '%MB');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''%MB'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
