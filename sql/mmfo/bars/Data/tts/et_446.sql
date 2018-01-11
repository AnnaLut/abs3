set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 447
prompt Наименование операции: На суму ПДВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('447', 'На суму ПДВ', 1, '#(#(NLSB))', 980, '#( nbs_ob22 (''3622'',''51'') )', 980, null, null, null, null, 0, 0, 0, 0, '#(S)/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='447', name='На суму ПДВ', dk=1, nlsm='#(#(NLSB))', kv=980, nlsk='#( nbs_ob22 (''3622'',''51'') )', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='447';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='447';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='447';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='447';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='447';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='447';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='447';
end;
/
prompt Создание / Обновление операции 448
prompt Наименование операции: 448 На суму комісії
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('448', '448 На суму комісії', 1, '#(#(NLSB))', 980, '#( nbs_ob22 (''6519'',''24'') )', 980, null, null, null, null, 0, 0, 0, 0, '#(S)*5/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='448', name='448 На суму комісії', dk=1, nlsm='#(#(NLSB))', kv=980, nlsk='#( nbs_ob22 (''6519'',''24'') )', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)*5/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='448';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='448';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='448';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='448';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='448';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='448';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='448';
end;
/
prompt Создание / Обновление операции 446
prompt Наименование операции: 446-Нарах. доходи за договор з приватними нотаріусами (іпотека/застава
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('446', '446-Нарах. доходи за договор з приватними нотаріусами (іпотека/застава', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000000000000000000000000000000000', 'Нараховані доходи за договорами з приватними нотаріусами(щодо власників предметів іпотеки/застави-фізичних осіб)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='446', name='446-Нарах. доходи за договор з приватними нотаріусами (іпотека/застава', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000000000000000000000000000000000', nazn='Нараховані доходи за договорами з приватними нотаріусами(щодо власників предметів іпотеки/застави-фізичних осіб)'
       where tt='446';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='446';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='446';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('447', '446', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''447'', ''446'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('448', '446', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''448'', ''446'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='446';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3578', '446', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3578'', ''446'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3739', '446', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3739'', ''446'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='446';
  begin
    insert into tts_vob(vob, tt, ord)
    values (138, '446', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 138, ''446'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='446';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '446', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''446'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '446', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''446'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='446';
  begin
    insert into folders_tts(idfo, tt)
    values (26, '446');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''446'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
