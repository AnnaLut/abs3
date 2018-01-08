set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции R02
prompt Наименование операции: p) R02 - Откат фазы B (КР)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('R02', 'p) R02 - Откат фазы B (КР)', 1, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='R02', name='p) R02 - Откат фазы B (КР)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='R02';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='R02';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='R02';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='R02';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='R02';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='R02';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='R02';
end;
/
commit;
