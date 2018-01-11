set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K65
prompt Наименование операции: K65 (доч.CAE) Комісія за прийом переказу по сист."CONTACT"(Дальні)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K65', 'K65 (доч.CAE) Комісія за прийом переказу по сист."CONTACT"(Дальні)', 0, '#(nbs_ob22 (''2909'',''64''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(69,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K65', name='K65 (доч.CAE) Комісія за прийом переказу по сист."CONTACT"(Дальні)', dk=0, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(69,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K65';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K65';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K65';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K65';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K65';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K65';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K65';
end;
/
commit;
