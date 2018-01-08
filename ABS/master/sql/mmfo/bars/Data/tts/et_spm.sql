set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SPM
prompt Наименование операции: SPM p) Реалізований результат
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SPM', 'SPM p) Реалізований результат', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SPM', name='SPM p) Реалізований результат', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000010000000000000', nazn=null
       where tt='SPM';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SPM';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SPM';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SPM';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SPM';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SPM';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SPM';
end;
/
commit;
