set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !3R
prompt Наименование операции: STOP-контроль(3 Рівень)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!3R', 'STOP-контроль(3 Рівень)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(161,'''','''','''',#(REF))', null, null, null, null, null, '0000100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!3R', name='STOP-контроль(3 Рівень)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(161,'''','''','''',#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='!3R';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!3R';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!3R';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!3R';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!3R';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!3R';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!3R';
end;
/
commit;
