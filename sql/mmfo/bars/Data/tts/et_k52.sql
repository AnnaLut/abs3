set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K52
prompt Наименование операции: (доч.CAR) Комісія за прийом переказу для системи "RIA"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K52', '(доч.CAR) Комісія за прийом переказу для системи "RIA"', 0, '#(nbs_ob22 (''2909'',''65''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(65,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K52', name='(доч.CAR) Комісія за прийом переказу для системи "RIA"', dk=0, nlsm='#(nbs_ob22 (''2909'',''65''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(65,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K52';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K52';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K52';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K52';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K52';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K52';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K52';
end;
/
commit;
