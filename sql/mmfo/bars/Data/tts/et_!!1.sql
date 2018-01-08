set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!1
prompt Наименование операции: aНБУ. STOP-контроль
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!1', 'aНБУ. STOP-контроль', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP( 1 , #(REF) , '''' ,  0 )', null, null, null, null, null, '0000100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!1', name='aНБУ. STOP-контроль', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP( 1 , #(REF) , '''' ,  0 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='!!1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!!1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!!1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!!1';
end;
/
commit;
