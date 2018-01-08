set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K22
prompt Наименование операции: K22 Комісія за конвертацію готівкових валют
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K22', 'K22 Комісія за конвертацію готівкових валют', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''6514'',''34''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(122,#(KVA),#(NLSA),#(S)),SYSDATE)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K22', name='K22 Комісія за конвертацію готівкових валют', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''6514'',''34''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(122,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K22';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K22';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K22';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K22';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K22';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K22';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K22';
end;
/
commit;
