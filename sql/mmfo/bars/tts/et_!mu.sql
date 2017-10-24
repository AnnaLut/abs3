set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !MU
prompt Наименование операции: STOP-правило на суму виплати переказу (екв <50000грн.)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!MU', 'STOP-правило на суму виплати переказу (екв <50000грн.)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(102,#(KVA),'''',#(S), #(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!MU', name='STOP-правило на суму виплати переказу (екв <50000грн.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(102,#(KVA),'''',#(S), #(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!MU';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!MU';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!MU';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!MU';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!MU';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!MU';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!MU';
end;
/
commit;
