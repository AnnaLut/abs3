set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ST5
prompt Наименование операции: ST5 STOP - СчетiА=СчетiБ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ST5', 'ST5 STOP - СчетiА=СчетiБ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP( 5, #(REF), #(NLSA), 0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ST5', name='ST5 STOP - СчетiА=СчетiБ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP( 5, #(REF), #(NLSA), 0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ST5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ST5';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ST5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ST5';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ST5';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ST5';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ST5';
end;
/
commit;
