set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CV4
prompt Наименование операции: d1 Конвертація безгот. вал. EUR<>USD
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CV4', 'd1 Конвертація безгот. вал. EUR<>USD', 1, null, 978, null, 978, null, null, null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CV4', name='d1 Конвертація безгот. вал. EUR<>USD', dk=1, nlsm=null, kv=978, nlsk=null, kvk=978, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CV4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CV4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CV4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CV4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CV4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CV4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CV4';
  begin
    insert into folders_tts(idfo, tt)
    values (3, 'CV4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 3, ''CV4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
