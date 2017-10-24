set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !BB
prompt Наименование операции: !BB STOP-правило на викуп суми менше номіналу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!BB', '!BB STOP-правило на викуп суми менше номіналу', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(111,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!BB', name='!BB STOP-правило на викуп суми менше номіналу', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(111,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!BB';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!BB';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!BB';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!BB';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!BB';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!BB';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!BB';
end;
/
commit;
