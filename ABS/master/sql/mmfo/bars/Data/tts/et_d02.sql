set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции D02
prompt Наименование операции: D02 p) D02 - Відкат фази B (ДБ)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D02', 'D02 p) D02 - Відкат фази B (ДБ)', 0, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='D02', name='D02 p) D02 - Відкат фази B (ДБ)', dk=0, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='D02';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D02';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D02';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D02';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D02';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D02';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D02';
end;
/
commit;
