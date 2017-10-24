set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции R01
prompt Наименование операции: p) R01 - Процессинг ( фаза B ) КР
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('R01', 'p) R01 - Процессинг ( фаза B ) КР', 1, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='R01', name='p) R01 - Процессинг ( фаза B ) КР', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010100000000000010000000000000', nazn=null
       where tt='R01';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='R01';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='R01';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='R01';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='R01';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='R01';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='R01';
end;
/
commit;
