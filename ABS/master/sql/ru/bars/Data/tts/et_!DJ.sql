set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !DJ
prompt Наименование операции: !DJ Заповнення дод.реквізитів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!DJ', '!DJ Заповнення дод.реквізитів', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_check_tag(#(REF),''REZID'')', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!DJ', name='!DJ Заповнення дод.реквізитів', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_check_tag(#(REF),''REZID'')', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!DJ';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!DJ';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!DJ';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!DJ';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!DJ';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!DJ';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!DJ';
end;
/
commit;
