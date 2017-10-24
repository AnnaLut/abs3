set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции FXR
prompt Наименование операции: ЦП: Внутрішнє (комісія)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FXR', 'ЦП: Внутрішнє (комісія)', 1, null, 980, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FXR', name='ЦП: Внутрішнє (комісія)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='FXR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='FXR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='FXR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='FXR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='FXR';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='FXR';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='FXR';
end;
/
commit;
