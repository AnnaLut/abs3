set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CLO
prompt Наименование операции: SWT->VPS Комісія Фонд Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLO', 'SWT->VPS Комісія Фонд Claims Conference', 1, '37397011', null, '19197202737', null, null, null, null, null, 0, 0, 0, 0, '225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLO', name='SWT->VPS Комісія Фонд Claims Conference', dk=1, nlsm='37397011', kv=null, nlsk='19197202737', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CLO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CLO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CLO';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CLO';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CLO';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CLO';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CLO';
end;
/
commit;
