set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 875
prompt Наименование операции: 875 - "ФОНД" комісія City Bank
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('875', '875 - "ФОНД" комісія City Bank', 1, null, 978, '19197202737', 978, null, null, '19197202737', null, 0, 0, 0, 0, '275', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='875', name='875 - "ФОНД" комісія City Bank', dk=1, nlsm=null, kv=978, nlsk='19197202737', kvk=978, nlss=null, nlsa=null, nlsb='19197202737', mfob=null, flc=0, fli=0, flv=0, flr=0, s='275', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='875';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='875';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='875';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='875';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='875';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='875';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='875';
end;
/
commit;
