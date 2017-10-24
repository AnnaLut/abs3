set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции REV
prompt Наименование операции: баланс "вiшалки" 3800
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('REV', 'баланс "вiшалки" 3800', null, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='REV', name='баланс "вiшалки" 3800', dk=null, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='REV';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='REV';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='REV';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='REV';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='REV';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='REV';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='REV';
end;
/
commit;
