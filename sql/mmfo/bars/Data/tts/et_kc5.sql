set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KC5
prompt Наименование операции: КC5 Комісія за прийом готівки для переказу без відкр. рах.
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KC5', 'КC5 Комісія за прийом готівки для переказу без відкр. рах.', 0, '#(nbs_ob22 (''6110'',''22''))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(33, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KC5', name='КC5 Комісія за прийом готівки для переказу без відкр. рах.', dk=0, nlsm='#(nbs_ob22 (''6110'',''22''))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(33, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='KC5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KC5';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KC5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KC5';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KC5';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KC5';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KC5';
end;
/
commit;
