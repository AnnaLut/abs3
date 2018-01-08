set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ST9
prompt Наименование операции: STOP - кореспонденція неприпустимих ПОЗАБАЛАНСОВИХ рах.
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ST9', 'STOP - кореспонденція неприпустимих ПОЗАБАЛАНСОВИХ рах.', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP( 9, #(REF), null, 0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ST9', name='STOP - кореспонденція неприпустимих ПОЗАБАЛАНСОВИХ рах.', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP( 9, #(REF), null, 0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ST9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ST9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ST9';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ST9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ST9';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ST9';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ST9';
end;
/
commit;
