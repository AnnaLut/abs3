set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции F4W
prompt Наименование операции: F4W-Списание с 2625/2620(карточный) на счет своего РУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('F4W', 'F4W-Списание с 2625/2620(карточный) на счет своего РУ', 1, '#(bpk_get_transit('''',#(NLSB),#(NLSA),#(KVA)))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000010000000000000000000000000000000000000', 'Списання з картрахунку коштів для зарахування коштів на інший рахунок в Ощадбанку');
  exception
    when dup_val_on_index then
      update tts set
        tt='F4W', name='F4W-Списание с 2625/2620(карточный) на счет своего РУ', dk=1, nlsm='#(bpk_get_transit('''',#(NLSB),#(NLSA),#(KVA)))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000010000000000000000000000000000000000000', nazn='Списання з картрахунку коштів для зарахування коштів на інший рахунок в Ощадбанку'
       where tt='F4W';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='F4W';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='F4W';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='F4W';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'F4W', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2625'', ''F4W'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'F4W', 0, '36');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''F4W'', 0, ''36'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'F4W', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2902'', ''F4W'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2909', 'F4W', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''F4W'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('3739', 'F4W', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3739'', ''F4W'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='F4W';
  begin
    insert into tts_vob(vob, tt)
    values (1, 'F4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''F4W'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (6, 'F4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''F4W'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='F4W';
  
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'F4W', 3, null, 'bpk_visa30(ref, 0)=1', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''F4W'', 3, null, ''bpk_visa30(ref, 0)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='F4W';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'F4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''F4W'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
