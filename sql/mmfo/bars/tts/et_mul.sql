set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MUL
prompt Наименование операции: 2909/56 - 2900/01 Для обов.продажу  (екв ,>=150 тис)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUL', '2909/56 - 2900/01 Для обов.продажу  (екв ,>=150 тис)', 1, null, null, '2900130100057', null, null, null, '2900130100057', null, 0, 0, 0, 0, 'F_CHECK_PAYMENT(#(REF),2)', 'F_CHECK_PAYMENT(#(REF),2)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUL', name='2909/56 - 2900/01 Для обов.продажу  (екв ,>=150 тис)', dk=1, nlsm=null, kv=null, nlsk='2900130100057', kvk=null, nlss=null, nlsa=null, nlsb='2900130100057', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT(#(REF),2)', s2='F_CHECK_PAYMENT(#(REF),2)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MUL';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MUL';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MUL';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MUL';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MUL';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MUL';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MUL';
end;
/
commit;
