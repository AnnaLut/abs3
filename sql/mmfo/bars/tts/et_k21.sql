set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K2K
prompt Наименование операции: K2K:Чиста комiсiя зг.вибраного тарифу.(доч K20,K21,KC0)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K2K', 'K2K:Чиста комiсiя зг.вибраного тарифу.(доч K20,K21,KC0)', 1, '#( to_char ( RAZ_KOM_PDV ((tobopack.GetTOBOParam(''TR3739_03'')), 3 ) ) )', null, null, null, null, null, null, null, 0, 0, 0, 0, 'RAZ_KOM_PDV ( ''0'',2  ) ', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K2K', name='K2K:Чиста комiсiя зг.вибраного тарифу.(доч K20,K21,KC0)', dk=1, nlsm='#( to_char ( RAZ_KOM_PDV ((tobopack.GetTOBOParam(''TR3739_03'')), 3 ) ) )', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='RAZ_KOM_PDV ( ''0'',2  ) ', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K2K';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K2K';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K2K';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K2K';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K2K';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K2K';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K2K';
end;
/
prompt Создание / Обновление операции K2P
prompt Наименование операции: K2P:ПДВ до комiсiї зг.вибраного тарифу.(доч K20,K21,KC0)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K2P', 'K2P:ПДВ до комiсiї зг.вибраного тарифу.(доч K20,K21,KC0)', 1, '#( to_char ( RAZ_KOM_PDV ((tobopack.GetTOBOParam(''TR3739_03'')), 3 ) ) )', null, '#( nbs_ob22 (''3622'',''51'') )', null, null, null, null, null, 0, 0, 0, 0, 'RAZ_KOM_PDV (''0'', 1 ) ', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K2P', name='K2P:ПДВ до комiсiї зг.вибраного тарифу.(доч K20,K21,KC0)', dk=1, nlsm='#( to_char ( RAZ_KOM_PDV ((tobopack.GetTOBOParam(''TR3739_03'')), 3 ) ) )', kv=null, nlsk='#( nbs_ob22 (''3622'',''51'') )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='RAZ_KOM_PDV (''0'', 1 ) ', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K2P';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K2P';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K2P';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K2P';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K2P';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K2P';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K2P';
end;
/
prompt Создание / Обновление операции K21
prompt Наименование операции: K21 Сплата комісії готівкою зг.вибраного тарифу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K21', 'K21 Сплата комісії готівкою зг.вибраного тарифу', 1, '#(tobopack.GetTOBOParam(''CASH''))', 980, '#( to_char ( RAZ_KOM_PDV ( #(NLSB), 3 ) ) )', 980, null, '#(tobopack.GetTOBOParam(''CASH''))', null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0000100001000001000000000000000000010000000000000000000000000000', '#(TARON)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K21', name='K21 Сплата комісії готівкою зг.вибраного тарифу', dk=1, nlsm='#(tobopack.GetTOBOParam(''CASH''))', kv=980, nlsk='#( to_char ( RAZ_KOM_PDV ( #(NLSB), 3 ) ) )', kvk=980, nlss=null, nlsa='#(tobopack.GetTOBOParam(''CASH''))', nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100001000001000000000000000000010000000000000000000000000000', nazn='#(TARON)'
       where tt='K21';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K21';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRS ', 'K21', 'O', 1, 9, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ADRS '', ''K21'', ''O'', 1, 9, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'K21', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ATRT '', ''K21'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DATN ', 'K21', 'O', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DATN '', ''K21'', ''O'', 1, 8, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'K21', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''K21'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NAMED', 'K21', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''NAMED'', ''K21'', ''O'', 1, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP2', 'K21', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP2'', ''K21'', ''O'', 1, 7, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'K21', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''K21'', ''O'', 1, 5, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PDV  ', 'K21', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PDV  '', ''K21'', ''M'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TAROB', 'K21', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TAROB'', ''K21'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TARON', 'K21', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TARON'', ''K21'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K21';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K2K', 'K21', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K2K'', ''K21'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K2P', 'K21', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K2P'', ''K21'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K21';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K21';
  begin
    insert into tts_vob(vob, tt, ord)
    values (155, 'K21', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 155, ''K21'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K21';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'K21', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''K21'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'K21', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''K21'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K21';
end;
/
commit;
