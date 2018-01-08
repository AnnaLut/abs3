set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !ZP
prompt Наименование операции: !ZP STOP-контроль (Зарплата)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!ZP', '!ZP STOP-контроль (Зарплата)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_ZP(#(REF))', null, null, null, '0', null, '0040M0000000000000000000040M000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!ZP', name='!ZP STOP-контроль (Зарплата)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_ZP(#(REF))', s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0040M0000000000000000000040M000000000000000000000000000000000000', nazn=null
       where tt='!ZP';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!ZP';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!ZP';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!ZP';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!ZP';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!ZP';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!ZP';
end;
/
commit;
