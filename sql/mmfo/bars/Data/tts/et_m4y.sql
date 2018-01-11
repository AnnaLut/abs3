set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции M4Y
prompt Наименование операции: M4Y 2909/OB22 - 2900/01 Для обов.продажу  (екв ,>=150 тис)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('M4Y', 'M4Y 2909/OB22 - 2900/01 Для обов.продажу  (екв ,>=150 тис)', 1, null, null, '#(nbs_ob22 (''2900'',''01''))', null, null, null, '#(nbs_ob22 (''2900'',''01''))', null, 0, 0, 0, 0, 'F_CHECK_PAYMENT_W4(''#(SUM_P)'', #(KVA),''#(PASPN)'',2)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='M4Y', name='M4Y 2909/OB22 - 2900/01 Для обов.продажу  (екв ,>=150 тис)', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''2900'',''01''))', kvk=null, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''2900'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT_W4(''#(SUM_P)'', #(KVA),''#(PASPN)'',2)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='M4Y';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='M4Y';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='M4Y';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='M4Y';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='M4Y';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='M4Y';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='M4Y';
end;
/
commit;
