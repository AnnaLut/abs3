set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K26
prompt Наименование операции: K26 Списано комісію за зарахування коштів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K26', 'K26 Списано комісію за зарахування коштів', 0, null, 980, '#(nbs_ob22 (''6510'',''17''))', 980, null, null, '#(nbs_ob22 (''6510'',''17''))', null, 0, 0, 0, 0, 'F_TARIF(70, #(KVA), #(NLSB), #(S) )', null, null, null, null, null, '0000100000000000000010000000000000000100000000000000000000000000', 'Списано комісію за зарахування коштів');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K26', name='K26 Списано комісію за зарахування коштів', dk=0, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''17''))', kvk=980, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6510'',''17''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(70, #(KVA), #(NLSB), #(S) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000100000000000000000000000000', nazn='Списано комісію за зарахування коштів'
       where tt='K26';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K26';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K26';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K26';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'K26', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''K26'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6510', 'K26', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6510'', ''K26'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K26';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K26';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K26';
end;
/
prompt Создание / Обновление операции D26
prompt Наименование операции: D26 Зарахування на рах.2620 з комісією
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D26', 'D26 Зарахування на рах.2620 з комісією', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1001100000000000000000000001000000010000000000000000000000000000', 'Зарахування коштів на рахунок Ф.О.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='D26', name='D26 Зарахування на рах.2620 з комісією', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100000000000000000000001000000010000000000000000000000000000', nazn='Зарахування коштів на рахунок Ф.О.'
       where tt='D26';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D26';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SK_ZB', 'D26', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''SK_ZB'', ''D26'', ''M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D26';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K26', 'D26', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K26'', ''D26'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D26';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'D26', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''D26'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'D26', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''D26'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D26';
  begin
    insert into tts_vob(vob, tt, ord)
    values (232, 'D26', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 232, ''D26'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D26';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'D26', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''D26'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'D26', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''D26'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D26';
  begin
    insert into folders_tts(idfo, tt)
    values (92, 'D26');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 92, ''D26'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
