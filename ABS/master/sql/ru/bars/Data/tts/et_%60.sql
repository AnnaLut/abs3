set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции %60
prompt Наименование операции: %60 d`(%%2) Нарахування відсотків (тiльки доходи)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%60', '%60 d`(%%2) Нарахування відсотків (тiльки доходи)', 1, null, null, null, 980, null, null, null, null, 0, 0, 1, 0, '#(S) - ROUND (  #(S)  / 6 , 0) ', '#(S2) - ROUND (  #(S2) / 6, 0) ', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%60', name='%60 d`(%%2) Нарахування відсотків (тiльки доходи)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='#(S) - ROUND (  #(S)  / 6 , 0) ', s2='#(S2) - ROUND (  #(S2) / 6, 0) ', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='%60';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='%60';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='%60';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='%60';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='%60';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='%60';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='%60';
end;
/
commit;
