set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции LUO
prompt Наименование операции: LUO Оприбуткування нестачі за вкладними операціями
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('LUO', 'LUO Оприбуткування нестачі за вкладними операціями', 1, '#(nbs_ob22 (''9618'',''06''))', 980, '#(nbs_ob22 (''9910'',''01''))', 980, null, '#(nbs_ob22 (''9618'',''06''))', '#(nbs_ob22 (''9910'',''01''))', null, 0, 0, 1, 1, '#(S2)', null, null, null, '0', null, '1001110000010000000000000001000000010000000000000000000000000000', 'Оприбуткування нестачі за вкладними операціямих осіб');
  exception
    when dup_val_on_index then 
      update tts
         set tt='LUO', name='LUO Оприбуткування нестачі за вкладними операціями', dk=1, nlsm='#(nbs_ob22 (''9618'',''06''))', kv=980, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''9618'',''06''))', nlsb='#(nbs_ob22 (''9910'',''01''))', mfob=null, flc=0, fli=0, flv=1, flr=1, s='#(S2)', s2=null, sk=null, proc=null, s3800='0', rang=null, flags='1001110000010000000000000001000000010000000000000000000000000000', nazn='Оприбуткування нестачі за вкладними операціямих осіб'
       where tt='LUO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='LUO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='LUO';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='LUO';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9618', 'LUO', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9618'', ''LUO'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', 'LUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9910'', ''LUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='LUO';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, 'LUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 206, ''LUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='LUO';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'LUO', 1, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''LUO'', 1, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'LUO', 2, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''LUO'', 2, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='LUO';
  begin
    insert into folders_tts(idfo, tt)
    values (26, 'LUO');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''LUO'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции MVN
prompt Наименование операции: MVN Вичвлення нестачі за вкладними операціями (дочірня)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MVN', 'MVN Вичвлення нестачі за вкладними операціями (дочірня)', 1, '#(nbs_ob22 (''7399'',''42''))', 980, '#(nbs_ob22 (''3739'',''04''))', 980, null, null, null, null, 0, 0, 0, 0, '#(S2)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MVN', name='MVN Вичвлення нестачі за вкладними операціями (дочірня)', dk=1, nlsm='#(nbs_ob22 (''7399'',''42''))', kv=980, nlsk='#(nbs_ob22 (''3739'',''04''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S2)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MVN';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MVN';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MVN';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MVN';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MVN';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MVN';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MVN';
end;
/
prompt Создание / Обновление операции MUO
prompt Наименование операции: MUO-Виявлення нестачі за вкладними операціями в ІВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUO', 'MUO-Виявлення нестачі за вкладними операціями в ІВ', 0, null, null, '#(nbs_ob22 (''3739'',''04''))', 980, null, null, '#(nbs_ob22 (''3739'',''04''))', null, 1, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '1001110000010000000000000001000000010000000000000000000000000000', 'Виявлення нестачі за вкладними операціями');
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUO', name='MUO-Виявлення нестачі за вкладними операціями в ІВ', dk=0, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''3739'',''04''))', kvk=980, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''3739'',''04''))', mfob=null, flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='1001110000010000000000000001000000010000000000000000000000000000', nazn='Виявлення нестачі за вкладними операціями'
       where tt='MUO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MUO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MUO';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('LUO', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''LUO'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MVN', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MVN'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MUO';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2628', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2628'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2630', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2630'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2635', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2635'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2638', 'MUO', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2638'', ''MUO'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3739', 'MUO', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3739'', ''MUO'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MUO';
  begin
    insert into tts_vob(vob, tt, ord)
    values (277, 'MUO', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 277, ''MUO'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MUO';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'MUO', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''MUO'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MUO', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''MUO'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MUO';
  begin
    insert into folders_tts(idfo, tt)
    values (50, 'MUO');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 50, ''MUO'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
