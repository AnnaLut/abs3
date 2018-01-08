set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MVN
prompt Наименование операции: Вичвлення нестачі за вкладними операціями (дочірня)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MVN', 'Вичвлення нестачі за вкладними операціями (дочірня)', 1, '#(nbs_ob22 (''7399'',''42''))', 980, '#(nbs_ob22 (''3739'',''04''))', 980, null, null, null, null, 0, 0, 0, 0, '#(S2)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MVN', name='Вичвлення нестачі за вкладними операціями (дочірня)', dk=1, nlsm='#(nbs_ob22 (''7399'',''42''))', kv=980, nlsk='#(nbs_ob22 (''3739'',''04''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S2)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MVN';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MVN';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MVN';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MVN';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MVN';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MVN';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MVN';
end;
/
commit;
