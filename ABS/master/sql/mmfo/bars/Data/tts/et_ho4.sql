set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции HO4
prompt Наименование операции: d: Прийом готівки (СК=29)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('HO4', 'd: Прийом готівки (СК=29)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, 29, null, null, null, '0000100001000000000001000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='HO4', name='d: Прийом готівки (СК=29)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=29, proc=null, s3800=null, rang=null, flags='0000100001000000000001000000000000000100000000000000000000000000', nazn=null
       where tt='HO4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='HO4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='HO4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='HO4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='HO4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='HO4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='HO4';
end;
/
commit;
