set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MGR
prompt Наименование операции: MGR -- Вместо старых операций (при миграции) --
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MGR', 'MGR -- Вместо старых операций (при миграции) --', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000200000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MGR', name='MGR -- Вместо старых операций (при миграции) --', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000200000000000000000000000000', nazn=null
       where tt='MGR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MGR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MGR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MGR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MGR';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MGR';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MGR';
end;
/
commit;
