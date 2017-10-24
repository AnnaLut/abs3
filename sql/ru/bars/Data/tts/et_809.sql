set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 809
prompt Наименование операции: 809 - Сума номіналу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('809', '809 - Сума номіналу', 1, null, null, '29003', null, null, null, null, null, 0, 0, 0, 0, '#(S)', '#(S)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='809', name='809 - Сума номіналу', dk=1, nlsm=null, kv=null, nlsk='29003', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2='#(S)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='809';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='809';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='809';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='809';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='809';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='809';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='809';
end;
/
commit;
