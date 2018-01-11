set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BMU
prompt Наименование операции: d на суму різниці між відпускною ціною НБУ та номін вартістю
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BMU', 'd на суму різниці між відпускною ціною НБУ та номін вартістю', 1, '#(NBS_OB22(''2909'',''23''))', 980, '#(NBS_OB22(''3500'',''07''))', 980, null, null, null, null, 0, 0, 0, 0, 'BMY (2 )', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BMU', name='d на суму різниці між відпускною ціною НБУ та номін вартістю', dk=1, nlsm='#(NBS_OB22(''2909'',''23''))', kv=980, nlsk='#(NBS_OB22(''3500'',''07''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BMY (2 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BMU';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BMU';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BMU';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BMU';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BMU';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BMU';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BMU';
end;
/
commit;
