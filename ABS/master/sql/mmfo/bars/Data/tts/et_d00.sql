set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции D00
prompt Наименование операции: p) D00 - Процесинг ( фаза А ) ДБ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D00', 'p) D00 - Процесинг ( фаза А ) ДБ', 0, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='D00', name='p) D00 - Процесинг ( фаза А ) ДБ', dk=0, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='D00';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D00';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D00';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D00';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D00';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D00';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D00';
end;
/
commit;
