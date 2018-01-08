set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции OVR
prompt Наименование операции: Погашение овердрафта
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OVR', 'Погашение овердрафта', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 10, '0000100000000000000000000000000000000100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OVR', name='Погашение овердрафта', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=10, flags='0000100000000000000000000000000000000100000000000010000000000000', nazn=null
       where tt='OVR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OVR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OVR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OVR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OVR';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OVR';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OVR';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'OVR');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''OVR'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
