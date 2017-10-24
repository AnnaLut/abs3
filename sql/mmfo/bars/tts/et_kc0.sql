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
prompt Создание / Обновление операции KC0
prompt Наименование операции: KC0 Сплата комісії безготів. зг.вибраного тарифу(кредити)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KC0', 'KC0 Сплата комісії безготів. зг.вибраного тарифу(кредити)', 1, null, 980, '#( to_char ( RAZ_KOM_PDV ( #(NLSB), 0 ) ) )', 980, null, null, null, null, 1, 0, 0, 0, 'f_cc_raz_komis(1, #(ND), #(TAROB))', null, null, null, null, null, '0000100000000001000000000001000000010000000000000000000000000000', 'Cплата комiсiї згiдно тарифу');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KC0', name='KC0 Сплата комісії безготів. зг.вибраного тарифу(кредити)', dk=1, nlsm=null, kv=980, nlsk='#( to_char ( RAZ_KOM_PDV ( #(NLSB), 0 ) ) )', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s='f_cc_raz_komis(1, #(ND), #(TAROB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000001000000000001000000010000000000000000000000000000', nazn='Cплата комiсiї згiдно тарифу'
       where tt='KC0';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KC0';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CC_ID', 'KC0', 'M', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CC_ID'', ''KC0'', ''M'', 1, 7, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DAT1 ', 'KC0', 'M', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DAT1 '', ''KC0'', ''M'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ND   ', 'KC0', 'M', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ND   '', ''KC0'', ''M'', 1, 8, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PDV  ', 'KC0', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PDV  '', ''KC0'', ''M'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TAROB', 'KC0', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TAROB'', ''KC0'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TARON', 'KC0', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TARON'', ''KC0'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KC0';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K2K', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K2K'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K2P', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K2P'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KC0';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2560', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2560'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2650', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2650'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3739', 'KC0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3739'', ''KC0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KC0';
  begin
    insert into tts_vob(vob, tt, ord)
    values (38, 'KC0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 38, ''KC0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KC0';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'KC0', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''KC0'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KC0';
end;
/
commit;
