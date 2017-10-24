set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W41
prompt Наименование операции: W41-Переказ коштів з арешт.рах. 2625 зг.плат. вимоги(міжбанк)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W41', 'W41-Переказ коштів з арешт.рах. 2625 зг.плат. вимоги(міжбанк)', 1, '#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '1301000000001000000000000010000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='W41', name='W41-Переказ коштів з арешт.рах. 2625 зг.плат. вимоги(міжбанк)', dk=1, nlsm='#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1301000000001000000000000010000000000000000000000000000000000000', nazn=null
       where tt='W41';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='W41';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W41';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W41';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2605', 'W41', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2605'', ''W41'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'W41', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2625'', ''W41'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2924', 'W41', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''W41'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='W41';
  begin
    insert into tts_vob(vob, tt)
    values (6, 'W41');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''W41'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W41';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'W41', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''W41'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'W41', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''W41'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'W41', 3, null, 'bpk_visa30(ref, 0)=1', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''W41'', 3, null, ''bpk_visa30(ref, 0)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='W41';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'W41');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''W41'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
