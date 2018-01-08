set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MUD
prompt Наименование операции: 2909/56 - 2620 - Для виплати (екв <150 тис)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUD', '2909/56 - 2620 - Для виплати (екв <150 тис)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_PAYMENT(#(REF),1)', 'F_CHECK_PAYMENT(#(REF),1)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUD', name='2909/56 - 2620 - Для виплати (екв <150 тис)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT(#(REF),1)', s2='F_CHECK_PAYMENT(#(REF),1)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MUD';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MUD';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MUD';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MUD';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MUD';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MUD';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MUD';
end;
/
commit;
