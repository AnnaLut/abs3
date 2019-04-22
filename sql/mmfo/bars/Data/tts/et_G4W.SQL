set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W46
prompt Наименование операции: W46 дочірня для W4O (міжбанк)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W46', 'W46 дочірня для W4O (міжбанк)', 1, null, null, '#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='W46', name='W46 дочірня для W4O (міжбанк)', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='W46';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='W46';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W46';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W46';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='W46';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W46';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='W46';
  
  
end;
/

prompt Создание / Обновление операции !!3
prompt Наименование операции: :STOP ! МФОА=МФОБ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!3', ':STOP ! МФОА=МФОБ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(3,#(MFOA),'''',#(MFOB))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!3', name=':STOP ! МФОА=МФОБ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(3,#(MFOA),'''',#(MFOB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!3';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='!!3';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!3';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!3';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='!!3';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!3';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='!!3';
  
  
end;
/

prompt Создание / Обновление операции G4W
prompt Наименование операции: G4W-Списание с 2625/2620(карточный) на счет чужого РУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G4W', 'G4W-Списание с 2625/2620(карточный) на счет чужого РУ', 1, '#(bpk_get_transit('''',''3739'',#(NLSA),#(KVA)))', 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 1, 1, 0, 0, null, null, null, null, '0', null, '0300100000000000000000000010000000000000000000000000000000000000', 'Списання з картрахунку коштів для зарахування коштів на інший рахунок в іншому банку');
  exception
    when dup_val_on_index then
      update tts set
        tt='G4W', name='G4W-Списание с 2625/2620(карточный) на счет чужого РУ', dk=1, nlsm='#(bpk_get_transit('''',''3739'',#(NLSA),#(KVA)))', kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0300100000000000000000000010000000000000000000000000000000000000', nazn='Списання з картрахунку коштів для зарахування коштів на інший рахунок в іншому банку'
       where tt='G4W';
  end;
  select count(*) into cnt_ from accounts where nls='0';
  if cnt_=0 then
  
  
  
    dbms_output.put_line('Счет валютной позиции 0 заданый в операции G4W не существует!');
  end if;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='G4W';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='G4W';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!3', 'G4W', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!!3'', ''G4W'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('W46', 'G4W', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''W46'', ''G4W'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='G4W';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'G4W', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2625'', ''G4W'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'G4W', 0, '36');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''G4W'', 0, ''36'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='G4W';
  begin
    insert into tts_vob(vob, tt)
    values (1, 'G4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''G4W'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (6, 'G4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''G4W'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G4W';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'G4W', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''G4W'', 3, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='G4W';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'G4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''G4W'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
