set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 099
prompt Наименование операции: 099 дочірня до 098
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('099', '099 дочірня до 098', 1, '#(nbs_ob22 (''9618'',''05''))', 980, '#(nbs_ob22 (''9910'',''01''))', 980, null, '#(nbs_ob22 (''9618'',''05''))', '#(nbs_ob22 (''9910'',''01''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='099', name='099 дочірня до 098', dk=1, nlsm='#(nbs_ob22 (''9618'',''05''))', kv=980, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''9618'',''05''))', nlsb='#(nbs_ob22 (''9910'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='099';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='099';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='099';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='099';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='099';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='099';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='099';
end;
/
commit;
