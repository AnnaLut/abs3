set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W4E
prompt Наименование операции: W4E-Списання з картрах. для зарахування на поточн.рах. в Ощадбанк
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W4E', 'W4E-Списання з картрах. для зарахування на поточн.рах. в Ощадбанк', 1, '#(bpk_get_transit('''',#(NLSB),#(NLSA),#(KVA)))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000010000000000000000000000000000000000000', 'Списання з картрахунку коштів для зарахування коштів на поточний рахунок в Ощадбанку');
  exception
    when dup_val_on_index then
      update tts set
        tt='W4E', name='W4E-Списання з картрах. для зарахування на поточн.рах. в Ощадбанк', dk=1, nlsm='#(bpk_get_transit('''',#(NLSB),#(NLSA),#(KVA)))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000010000000000000000000000000000000000000', nazn='Списання з картрахунку коштів для зарахування коштів на поточний рахунок в Ощадбанку'
       where tt='W4E';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='W4E';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W4E';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W4E';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'W4E', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''W4E'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'W4E', 0, '23');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2625'', ''W4E'', 0, ''23'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'W4E', 0, '24');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2625'', ''W4E'', 0, ''24'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2909', 'W4E', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''W4E'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='W4E';
  begin
    insert into tts_vob(vob, tt)
    values (6, 'W4E');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''W4E'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W4E';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'W4E', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''W4E'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'W4E', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''W4E'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'W4E', 3, null, 'bpk_visa30(ref, 0)=1', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''W4E'', 3, null, ''bpk_visa30(ref, 0)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='W4E';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'W4E');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''W4E'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
