set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SWI
prompt Наименование операции: :b Импорт из SWIFT
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SWI', ':b Импорт из SWIFT', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SWI', name=':b Импорт из SWIFT', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='SWI';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SWI';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SWI';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SWI';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SWI';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SWI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SWI'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SWI';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SWI', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''SWI'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, 'SWI', 2, null, 'mfob=300465 and substr(nlsb,1,4) in (''2513'',''2525'',''2600'',''2602'',''2603'',''2604'',''2650'',''2620'',''2909'') and kv<>980', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 7, ''SWI'', 2, null, ''mfob=300465 and substr(nlsb,1,4) in (''''2513'''',''''2525'''',''''2600'''',''''2602'''',''''2603'''',''''2604'''',''''2650'''',''''2620'''',''''2909'''') and kv<>980'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SWI';
  begin
    insert into folders_tts(idfo, tt)
    values (72, 'SWI');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 72, ''SWI'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
