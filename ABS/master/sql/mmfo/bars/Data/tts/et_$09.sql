set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции $09
prompt Наименование операции: $09 4.9.Погаш.Ном+Ост.Купону:кiлькiсть
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('$09', '$09 4.9.Погаш.Ном+Ост.Купону:кiлькiсть', 1, '#(f_dop(#(REF), ''O9819''))', 980, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', 980, null, null, null, null, 0, 0, 0, 0, ' #(S_KIL) *100', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='$09', name='$09 4.9.Погаш.Ном+Ост.Купону:кiлькiсть', dk=1, nlsm='#(f_dop(#(REF), ''O9819''))', kv=980, nlsk='#(branch_usr.get_branch_param2(''NLS_9910'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=' #(S_KIL) *100', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='$09';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='$09';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='$09';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='$09';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='$09';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='$09';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='$09';
end;
/
commit;
