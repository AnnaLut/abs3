set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BAK
prompt Наименование операции: BAK(p) Виконання сторно-операції
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BAK', 'BAK(p) Виконання сторно-операції', null, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, 30, null, '0', 99, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BAK', name='BAK(p) Виконання сторно-операції', dk=null, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=30, proc=null, s3800='0', rang=99, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BAK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BAK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BAK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BAK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BAK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BAK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BAK';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'BAK');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''BAK'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
