set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DO1
prompt Наименование операции: DO1 Нарах. доходи банку від оренди (приміщень,POS-термінал) без ПДВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DO1', 'DO1 Нарах. доходи банку від оренди (приміщень,POS-термінал) без ПДВ', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, '#(S)-round(#(S)/6)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DO1', name='DO1 Нарах. доходи банку від оренди (приміщень,POS-термінал) без ПДВ', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-round(#(S)/6)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DO1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DO1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DO1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DO1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DO1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DO1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DO1';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'DO1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''DO1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции DO2
prompt Наименование операции: DO2 ПДВ із суми нарах.доходів Банку від оренди (приміщень,POS-термінал
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DO2', 'DO2 ПДВ із суми нарах.доходів Банку від оренди (приміщень,POS-термінал', 1, null, 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, null, null, null, 0, 0, 0, 0, 'round(#(S)/6)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DO2', name='DO2 ПДВ із суми нарах.доходів Банку від оренди (приміщень,POS-термінал', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='round(#(S)/6)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DO2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DO2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DO2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DO2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DO2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DO2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DO2';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'DO2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''DO2'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции DOR
prompt Наименование операции: DOR  Нарах.доходів банку від оренди (приміщень,POS-терміналів)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DOR', 'DOR  Нарах.доходів банку від оренди (приміщень,POS-терміналів)', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1001100000000000000000000000000000010300000000000000000000000000', 'Нарахування доходів Банку від оренди приміщень, платіжних пристроїв (POS-терміналів)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DOR', name='DOR  Нарах.доходів банку від оренди (приміщень,POS-терміналів)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100000000000000000000000000000010300000000000000000000000000', nazn='Нарахування доходів Банку від оренди приміщень, платіжних пристроїв (POS-терміналів)'
       where tt='DOR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DOR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DOR';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DO1', 'DOR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''DO1'', ''DOR'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DO2', 'DOR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''DO2'', ''DOR'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DOR';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3578', 'DOR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3578'', ''DOR'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6395', 'DOR', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6395'', ''DOR'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6395', 'DOR', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6395'', ''DOR'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DOR';
  begin
    insert into tts_vob(vob, tt, ord)
    values (172, 'DOR', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 172, ''DOR'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DOR';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DOR', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''DOR'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DOR', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DOR'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DOR';
  begin
    insert into folders_tts(idfo, tt)
    values (26, 'DOR');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''DOR'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
