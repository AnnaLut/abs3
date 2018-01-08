set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции HO5
prompt Наименование операции: d: Прийом готівки (СК=14)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('HO5', 'd: Прийом готівки (СК=14)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, 14, null, null, null, '0000100001000000000001000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='HO5', name='d: Прийом готівки (СК=14)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=14, proc=null, s3800=null, rang=null, flags='0000100001000000000001000000000000000100000000000000000000000000', nazn=null
       where tt='HO5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='HO5';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='HO5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='HO5';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='HO5';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='HO5';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='HO5';
end;
/
commit;
