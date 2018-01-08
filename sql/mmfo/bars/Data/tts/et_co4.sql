set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CO4
prompt Наименование операции: CO4 Комісія банку за прийом переказу "CONTACT" (залишок)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CO4', 'CO4 Комісія банку за прийом переказу "CONTACT" (залишок)', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''6510'',''B3''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', 'Комісія банку за прийом переказу "CONTACT" (залишок), що належить установі банку (ВИКЛЮЧЕННЯ)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CO4', name='CO4 Комісія банку за прийом переказу "CONTACT" (залишок)', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B3''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Комісія банку за прийом переказу "CONTACT" (залишок), що належить установі банку (ВИКЛЮЧЕННЯ)'
       where tt='CO4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CO4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CO4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CO4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CO4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''CO4'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6110', 'CO4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6110'', ''CO4'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CO4';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'CO4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''CO4'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CO4';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CO4', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CO4'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CO4';
  begin
    insert into folders_tts(idfo, tt)
    values (42, 'CO4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 42, ''CO4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
