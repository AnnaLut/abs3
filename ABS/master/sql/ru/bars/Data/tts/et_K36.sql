set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K36
prompt Наименование операции: (доч.CA1) Комісія за прийом переказу для Вестерн Юніон
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K36', '(доч.CA1) Комісія за прийом переказу для Вестерн Юніон', 0, '#(nbs_ob22 (''2909'',''27''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_OP(2, 36, #(KVA), #(S), #(NLSA),''CA1'', 0.776)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K36', name='(доч.CA1) Комісія за прийом переказу для Вестерн Юніон', dk=0, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_OP(2, 36, #(KVA), #(S), #(NLSA),''CA1'', 0.776)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K36';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K36';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K36';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K36';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K36';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K36';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K36';
end;
/
commit;
