set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции RSM
prompt Наименование операции: RSM Перерахування коштів на користь Клієнтів (зовнішній)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('RSM', 'RSM Перерахування коштів на користь Клієнтів (зовнішній)', 1, null, null, null, null, null, null, '#nbs_ob22(''3739'', ''00'')', null, 1, 0, 0, 0, null, null, null, null, null, null, '0201100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='RSM', name='RSM Перерахування коштів на користь Клієнтів (зовнішній)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='#nbs_ob22(''3739'', ''00'')', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0201100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='RSM';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='RSM';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='RSM';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='RSM';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='RSM';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'RSM', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''RSM'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='RSM';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='RSM';
end;
/
commit;
