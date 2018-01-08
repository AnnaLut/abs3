set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K12
prompt Наименование операции: K12 (доч.CAA) Комісія за прийом готівки для переказу по системі SWIFT
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K12', 'K12 (доч.CAA) Комісія за прийом готівки для переказу по системі SWIFT', 0, '#(nbs_ob22 (''6514'',''14''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CAA(#(REF),#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K12', name='K12 (доч.CAA) Комісія за прийом готівки для переказу по системі SWIFT', dk=0, nlsm='#(nbs_ob22 (''6514'',''14''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CAA(#(REF),#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K12';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K12';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K12';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K12';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K12';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K12';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K12';
end;
/
commit;
