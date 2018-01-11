set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции RT2
prompt Наименование операции: RT2 p) !!!
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('RT2', 'RT2 p) !!!', 1, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='RT2', name='RT2 p) !!!', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='RT2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='RT2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='RT2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='RT2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='RT2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='RT2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='RT2';
end;
/
commit;
