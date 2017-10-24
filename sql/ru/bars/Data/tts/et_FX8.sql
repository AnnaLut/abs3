set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции FX8
prompt Наименование операции: ЦП Iнш.ем./IHЗ.вал
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FX8', 'ЦП Iнш.ем./IHЗ.вал', null, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FX8', name='ЦП Iнш.ем./IHЗ.вал', dk=null, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='FX8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='FX8';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='FX8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='FX8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='FX8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='FX8';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='FX8';
end;
/
commit;
