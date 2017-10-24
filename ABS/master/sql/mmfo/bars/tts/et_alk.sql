set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ALK
prompt Наименование операции: Комiсiя по ALT* 2620* рахункам
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ALK', 'Комiсiя по ALT* 2620* рахункам', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ALK', name='Комiсiя по ALT* 2620* рахункам', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ALK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ALK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ALK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ALK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ALK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ALK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ALK';
end;
/
commit;
