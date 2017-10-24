set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CCA
prompt Наименование операции: CCA/ Погашення кредиту готівкою(ком за достр. погаш.)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CCA', 'CCA/ Погашення кредиту готівкою(ком за достр. погаш.)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, 14, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CCA', name='CCA/ Погашення кредиту готівкою(ком за достр. погаш.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=14, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CCA';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CCA';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CCA';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CCA';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CCA';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CCA';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CCA';
end;
/
commit;
