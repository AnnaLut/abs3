set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VB3
prompt Наименование операции: VB3 Коміс.дохід за послуги з розповсюдження л/білетів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB3', 'VB3 Коміс.дохід за послуги з розповсюдження л/білетів', 1, null, 980, '#(nbs_ob22 (''6510'',''60''))', 980, null, null, null, null, 0, 0, 0, 0, '#(S)*0.06', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB3', name='VB3 Коміс.дохід за послуги з розповсюдження л/білетів', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''60''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)*0.06', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VB3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VB3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VB3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VB3';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VB3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VB3';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB3');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VB3'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции VB4
prompt Наименование операции: VB4 Коміс.дохід за операціями з лотерейними білетами
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB4', 'VB4 Коміс.дохід за операціями з лотерейними білетами', 1, null, 980, '#(nbs_ob22 (''6510'',''01''))', 980, null, null, null, null, 0, 0, 0, 0, '(#(S)*0.01)-(#(S)*0.01)/6', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB4', name='VB4 Коміс.дохід за операціями з лотерейними білетами', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''01''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(#(S)*0.01)-(#(S)*0.01)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VB4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VB4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VB4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VB4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VB4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VB4';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VB4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции VB5
prompt Наименование операции: VB5 ПДВ від продажу лотерейних білетів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB5', 'VB5 ПДВ від продажу лотерейних білетів', 1, null, 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, null, null, null, 0, 0, 0, 0, '(#(S)*0.01)/6', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB5', name='VB5 ПДВ від продажу лотерейних білетів', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(#(S)*0.01)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VB5';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VB5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VB5';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VB5';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VB5';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VB5';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB5');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VB5'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции VB1
prompt Наименование операции: VB1 Розподіл коміс.доходу від реал. УКР.НАЦ.ЛОТЕРЕЇ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB1', 'VB1 Розподіл коміс.доходу від реал. УКР.НАЦ.ЛОТЕРЕЇ', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010300000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB1', name='VB1 Розподіл коміс.доходу від реал. УКР.НАЦ.ЛОТЕРЕЇ', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010300000000000000000000000000', nazn=null
       where tt='VB1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VB1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VB1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VB3', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''VB3'', ''VB1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VB4', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''VB4'', ''VB1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VB5', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''VB5'', ''VB1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VB1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2905', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2905'', ''VB1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2905', 'VB1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2905'', ''VB1'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VB1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (22, 'VB1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 22, ''VB1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VB1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'VB1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''VB1'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VB1';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VB1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
