set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 82P
prompt Наименование операции: 82P(d)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('82P', '82P(d)', 1, null, null, '64992010301017', null, null, null, null, null, 0, 0, 0, 0, '#(S)-#(S)/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='82P', name='82P(d)', dk=1, nlsm=null, kv=null, nlsk='64992010301017', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='82P';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='82P';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='82P';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='82P';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='82P';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='82P';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='82P';
end;
/
commit;
