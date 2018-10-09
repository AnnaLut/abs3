set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!U
prompt Наименование операции: STOP правило на операції з БПК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!U', 'STOP правило на операції з БПК', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(''9996'',#(KVA),#(NLSB),#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!U', name='STOP правило на операції з БПК', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(''9996'',#(KVA),#(NLSB),#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!U';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!!U';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!U';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!U';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!!U';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!U';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!!U';
end;
/
commit;
