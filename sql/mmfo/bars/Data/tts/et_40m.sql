set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 40M
prompt Наименование операции: 40M  Перерахування коштів на рах. акредит. нотаріуса (з коміс
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('40M', '40M  Перерахування коштів на рах. акредит. нотаріуса (з коміс', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000010000000000000000000000000000', 'За надані послуги в рамках кредитного договору №____ від __________ ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='40M', name='40M  Перерахування коштів на рах. акредит. нотаріуса (з коміс', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000010000000000000000000000000000', nazn='За надані послуги в рамках кредитного договору №____ від __________ '
       where tt='40M';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='40M';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='40M';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='40M';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='40M';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='40M';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '40M', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''40M'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '40M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''40M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='40M';
end;
/
commit;
