set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MA1
prompt Наименование операции: Дочірня до MAS
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MA1', 'Дочірня до MAS', 1, '#(nbs_ob22 (''2920'',''00''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MA1', name='Дочірня до MAS', dk=1, nlsm='#(nbs_ob22 (''2920'',''00''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MA1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MA1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MA1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MA1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MA1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MA1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MA1';
end;
/
commit;
