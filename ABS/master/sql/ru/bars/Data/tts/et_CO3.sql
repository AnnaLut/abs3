set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CO3
prompt Наименование операции: CO3 Комісія банку за прийом переказу "CONTACT"(залиш) - агенту
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CO3', 'CO3 Комісія банку за прийом переказу "CONTACT"(залиш) - агенту', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''2909'',''64''))', null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0001100000000000000000000001000000010000000000000000000000000000', 'Конвертація на суму комісії прийнятої у клієнтів в НВ, що належить агенту (ВИКЛЮЧЕННЯ за переказами "CONTACT")');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CO3', name='CO3 Комісія банку за прийом переказу "CONTACT"(залиш) - агенту', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''64''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0001100000000000000000000001000000010000000000000000000000000000', nazn='Конвертація на суму комісії прийнятої у клієнтів в НВ, що належить агенту (ВИКЛЮЧЕННЯ за переказами "CONTACT")'
       where tt='CO3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CO3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CO3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CO3';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CO3', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''CO3'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CO3', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''CO3'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CO3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (13, 'CO3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 13, ''CO3'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CO3';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CO3', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CO3'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CO3';
  begin
    insert into folders_tts(idfo, tt)
    values (42, 'CO3');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 42, ''CO3'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
