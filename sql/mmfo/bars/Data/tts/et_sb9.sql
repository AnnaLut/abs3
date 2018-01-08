set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SB9
prompt Наименование операции: SB9 Списання з позаб. оприбутк.цінностей банкнот після досл. від НБУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SB9', 'SB9 Списання з позаб. оприбутк.цінностей банкнот після досл. від НБУ', 1, '#(nbs_ob22 (''9899'',''C4''))', null, '#(nbs_ob22 (''9910'',''01''))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SB9', name='SB9 Списання з позаб. оприбутк.цінностей банкнот після досл. від НБУ', dk=1, nlsm='#(nbs_ob22 (''9899'',''C4''))', kv=null, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='SB9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SB9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SB9';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SB9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SB9';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SB9';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SB9';
end;
/
commit;
