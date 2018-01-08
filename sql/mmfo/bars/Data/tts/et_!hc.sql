set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !HC
prompt Наименование операции: STOP-правило на суму виплати для чеків (екв <50000грн.)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!HC', 'STOP-правило на суму виплати для чеків (екв <50000грн.)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(155,#(KVA),'''',#(S), #(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!HC', name='STOP-правило на суму виплати для чеків (екв <50000грн.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(155,#(KVA),'''',#(S), #(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!HC';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!HC';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!HC';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!HC';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!HC';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!HC';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!HC';
end;
/
commit;
