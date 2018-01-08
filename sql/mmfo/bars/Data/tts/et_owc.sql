set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции OWC
prompt Наименование операции: OWC Дочірня до OW9  комісія
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWC', 'OWC Дочірня до OW9  комісія', 1, '#(GetGlobalOption(''NLS_373914_LOCPAYFEE''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWC', name='OWC Дочірня до OW9  комісія', dk=1, nlsm='#(GetGlobalOption(''NLS_373914_LOCPAYFEE''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='OWC';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OWC';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OWC';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OWC';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OWC';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OWC';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OWC';
end;
/
commit;
