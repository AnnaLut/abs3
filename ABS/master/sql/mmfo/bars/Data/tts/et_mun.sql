set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции LUN
prompt Наименование операции: LUN Оприбуткування нестачі за вкладними операціями
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('LUN', 'LUN Оприбуткування нестачі за вкладними операціями', 0, '#(nbs_ob22 (''9618'',''06''))', 980, '#(nbs_ob22 (''9910'',''01''))', 980, null, '#(nbs_ob22 (''9618'',''06''))', '#(nbs_ob22 (''9910'',''01''))', null, 0, 0, 0, 1, null, null, null, null, null, null, '1001100000000000000000000001000000010000000000000000000000000000', 'Оприбуткування нестачі за вкладними операціямих осіб');
  exception
    when dup_val_on_index then 
      update tts
         set tt='LUN', name='LUN Оприбуткування нестачі за вкладними операціями', dk=0, nlsm='#(nbs_ob22 (''9618'',''06''))', kv=980, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''9618'',''06''))', nlsb='#(nbs_ob22 (''9910'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100000000000000000000001000000010000000000000000000000000000', nazn='Оприбуткування нестачі за вкладними операціямих осіб'
       where tt='LUN';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='LUN';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='LUN';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='LUN';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9618', 'LUN', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9618'', ''LUN'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', 'LUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9910'', ''LUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='LUN';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, 'LUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 206, ''LUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='LUN';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'LUN', 1, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''LUN'', 1, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'LUN', 2, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''LUN'', 2, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='LUN';
  begin
    insert into folders_tts(idfo, tt)
    values (26, 'LUN');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''LUN'') - первичный ключ не найден!');
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
prompt Создание / Обновление операции MUN
prompt Наименование операции: MUN-Виявлення нестачі за вкладними операціями в НВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUN', 'MUN-Виявлення нестачі за вкладними операціями в НВ', 1, '#(nbs_ob22 (''3739'',''04''))', 980, null, 980, null, '#(nbs_ob22 (''3739'',''04''))', null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1001100000000000000000000001000000010000000000000000000000000000', 'Виявлення нестачі за вкладними операціями');
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUN', name='MUN-Виявлення нестачі за вкладними операціями в НВ', dk=1, nlsm='#(nbs_ob22 (''3739'',''04''))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(nbs_ob22 (''3739'',''04''))', nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100000000000000000000001000000010000000000000000000000000000', nazn='Виявлення нестачі за вкладними операціями'
       where tt='MUN';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MUN';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MUN';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('LUN', 'MUN', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''LUN'', ''MUN'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MVN', 'MUN', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MVN'', ''MUN'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MUN';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''MUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2628', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2628'', ''MUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2630', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2630'', ''MUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2635', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2635'', ''MUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2638', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2638'', ''MUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3739', 'MUN', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3739'', ''MUN'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MUN';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, 'MUN', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 206, ''MUN'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (277, 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 277, ''MUN'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MUN';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'MUN', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''MUN'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MUN', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''MUN'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MUN';
  begin
    insert into folders_tts(idfo, tt)
    values (50, 'MUN');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 50, ''MUN'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
