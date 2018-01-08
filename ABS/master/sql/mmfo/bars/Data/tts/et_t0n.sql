set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции T0N
prompt Наименование операции: д. Внесення готівки на рах.акредитованого нотаріуса   
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('T0N', 'д. Внесення готівки на рах.акредитованого нотаріуса   ', 1, null, 980, '#(nbs_ob22(''2902'',''06''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='T0N', name='д. Внесення готівки на рах.акредитованого нотаріуса   ', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22(''2902'',''06''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='T0N';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='T0N';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='T0N';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='T0N';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='T0N';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='T0N';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='T0N';
end;
/
commit;
