set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !$7
prompt Наименование операции: STOP-правило по 758 постанове НБУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!$7', 'STOP-правило по 758 постанове НБУ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(758,0,'''',0,#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!$7', name='STOP-правило по 758 постанове НБУ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(758,0,'''',0,#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!$7';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!$7';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!$7';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!$7';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!$7';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!$7';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!$7';
end;
/
commit;
