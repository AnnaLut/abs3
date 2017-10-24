set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K37
prompt Наименование операции: (доч.CA2) Комісія за прийом переказу для MIGOM
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K37', '(доч.CA2) Комісія за прийом переказу для MIGOM', 0, '#(nbs_ob22 (''2909'',''40''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_OP(2, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K37', name='(доч.CA2) Комісія за прийом переказу для MIGOM', dk=0, nlsm='#(nbs_ob22 (''2909'',''40''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_OP(2, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K37';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K37';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K37';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K37';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K37';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K37';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K37';
end;
/
commit;
