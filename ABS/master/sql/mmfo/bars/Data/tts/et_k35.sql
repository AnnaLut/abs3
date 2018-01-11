set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K35
prompt Наименование операции: K35 К35 Комісія за видачу коштів VISA клієнтам ін.банків
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K35', 'K35 К35 Комісія за видачу коштів VISA клієнтам ін.банків', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2 (''NLS_651061'',0))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(25,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'Комісія за видачу коштів по БПК "VISA" клієнту іншого банку');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K35', name='K35 К35 Комісія за видачу коштів VISA клієнтам ін.банків', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2 (''NLS_651061'',0))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(25,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='Комісія за видачу коштів по БПК "VISA" клієнту іншого банку'
       where tt='K35';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K35';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K35';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K35';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K35';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K35';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K35';
end;
/
commit;
