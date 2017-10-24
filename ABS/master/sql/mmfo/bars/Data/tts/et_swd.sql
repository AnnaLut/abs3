set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SWD
prompt Наименование операции: SWD-Раздача деталей МТ102 с ТРАНЗИТА
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SWD', 'SWD-Раздача деталей МТ102 с ТРАНЗИТА', 1, '37391006', null, null, null, null, '37391006', null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SWD', name='SWD-Раздача деталей МТ102 с ТРАНЗИТА', dk=1, nlsm='37391006', kv=null, nlsk=null, kvk=null, nlss=null, nlsa='37391006', nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='SWD';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SWD';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SWD';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SWD';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SWD';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SWD', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SWD'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SWD';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'SWD', 4, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''SWD'', 4, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SWD', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''SWD'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, 'SWD', 2, null, 'mfob=300465 and substr(nlsb,1,4) in (''2513'',''2525'',''2600'',''2602'',''2603'',''2604'',''2650'',''2620'',''2909'') and kv<>980', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 7, ''SWD'', 2, null, ''mfob=300465 and substr(nlsb,1,4) in (''''2513'''',''''2525'''',''''2600'''',''''2602'''',''''2603'''',''''2604'''',''''2650'''',''''2620'''',''''2909'''') and kv<>980'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SWD';
  begin
    insert into folders_tts(idfo, tt)
    values (72, 'SWD');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 72, ''SWD'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
