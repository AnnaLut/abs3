set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SM5
prompt Наименование операции: SM5 Сплата комісії за перерахування платежів з оплати комунальних послуг
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SM5', 'Сплата комісії за перерахування платежів з оплати ком.послуг', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', 'Сплата комісії за перерахування платежів з оплати ком.послуг');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SM5', name='Сплата комісії за перерахування платежів з оплати ком.послуг', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Сплата комісії за перерахування платежів з оплати ком.послуг'
       where tt='SM5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SM5';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SM5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SM5';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'SM5', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''SM5'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3570', 'SM5', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3570'', ''SM5'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SM5';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SM5', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SM5'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SM5';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'SM5', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''SM5'', 3, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SM5';

end;
/
commit;
