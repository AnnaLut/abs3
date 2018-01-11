set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции M4X
prompt Наименование операции: M4X W4R. Stop-правило
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('M4X', 'M4X W4R. Stop-правило', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_stop(104, #(REF), '''', 0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='M4X', name='M4X W4R. Stop-правило', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_stop(104, #(REF), '''', 0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='M4X';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='M4X';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='M4X';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='M4X';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='M4X';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='M4X';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='M4X';
end;
/
commit;
