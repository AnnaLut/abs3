set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции FXK
prompt Наименование операции: FXK FOREX: Результат переоцiнки 9202-9212
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FXK', 'FXK FOREX: Результат переоцiнки 9202-9212', 1, null, 980, '62045010119017', 980, null, '354001', '364091', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FXK', name='FXK FOREX: Результат переоцiнки 9202-9212', dk=1, nlsm=null, kv=980, nlsk='62045010119017', kvk=980, nlss=null, nlsa='354001', nlsb='364091', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='FXK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='FXK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='FXK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='FXK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='FXK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='FXK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='FXK';
  begin
    insert into folders_tts(idfo, tt)
    values (71, 'FXK');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 71, ''FXK'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
