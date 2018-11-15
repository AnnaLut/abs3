set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции IBC
prompt Наименование операции: Дочірня для IBP (списання комісії)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IBC', 'Дочірня для IBP (списання комісії)', 1, '#(#(NLSA))', 980, '#(nbs_ob22_3570 (''3570'',''59'',#(NLSA),980))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(1000, #(KVA),#(NLSA), #(S))', null, null, 0, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='IBC', name='Дочірня для IBP (списання комісії)', dk=1, nlsm='#(#(NLSA))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''59'',#(NLSA),980))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(1000, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=0, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='IBC';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='IBC';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IBC';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IBC';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='IBC';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IBC';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='IBC';
  
  
end;
/


commit;
