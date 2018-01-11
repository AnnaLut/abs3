set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции МГР
prompt Наименование операции: МГР Проводки из СКАРБ-6
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('МГР', 'МГР Проводки из СКАРБ-6', null, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000010000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='МГР', name='МГР Проводки из СКАРБ-6', dk=null, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000010000000000000000000000000', nazn=null
       where tt='МГР';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='МГР';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='МГР';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='МГР';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='МГР';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='МГР';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='МГР';
end;
/
commit;
