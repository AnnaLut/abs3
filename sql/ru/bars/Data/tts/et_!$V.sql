set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !$V
prompt Наименование операции: STOP правило для облігацій заповнення доп реквізитів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!$V', 'STOP правило для облігацій заповнення доп реквізитів', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_stop(80840,#(ref),'''',0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!$V', name='STOP правило для облігацій заповнення доп реквізитів', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_stop(80840,#(ref),'''',0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!$V';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!$V';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!$V';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!$V';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!$V';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!$V';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!$V';
end;
/
commit;
