set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DT2
prompt Наименование операции: DT2 p) !!!
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DT2', 'DT2 p) !!!', 0, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DT2', name='DT2 p) !!!', dk=0, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='DT2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DT2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DT2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DT2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DT2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DT2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DT2';
end;
/
commit;
