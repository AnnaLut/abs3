set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !AG
prompt Наименование операции: !AG STOP-правило перевірки серії та номеру документа
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AG', '!AG STOP-правило перевірки серії та номеру документа', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(151,#(KVA),'''',#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AG', name='!AG STOP-правило перевірки серії та номеру документа', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(151,#(KVA),'''',#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!AG';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!AG';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!AG';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!AG';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!AG';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!AG';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!AG';
end;
/
commit;
