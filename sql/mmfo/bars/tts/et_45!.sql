set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 45!
prompt Наименование операции: Валюта 1 групи(дебет)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('45!', 'Валюта 1 групи(дебет)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(988,#(KVA),#(KVB),0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='45!', name='Валюта 1 групи(дебет)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(988,#(KVA),#(KVB),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='45!';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='45!';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='45!';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='45!';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='45!';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='45!';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='45!';
end;
/
commit;
