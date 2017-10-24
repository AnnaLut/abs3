set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции G0M
prompt Наименование операции: Погаш.комiсiї за внесення гот. на рах.акред.нотаріуса
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0M', 'Погаш.комiсiї за внесення гот. на рах.акред.нотаріуса', 1, null, 980, '#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', 980, null, null, null, null, 0, 0, 0, 0, '0.2*#(S)', null, null, null, null, null, '0000100000000000000010000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0M', name='Погаш.комiсiї за внесення гот. на рах.акред.нотаріуса', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0.2*#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000100000000000000000000000000', nazn=null
       where tt='G0M';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='G0M';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='G0M';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='G0M';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='G0M';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G0M';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='G0M';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'G0M');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''G0M'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции K0M
prompt Наименование операции: Нар.комiсії за пререрах.коштів на рах.акредит.нотаріуса
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0M', 'Нар.комiсії за пререрах.коштів на рах.акредит.нотаріуса', 1, '#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', 980, '#(BEZN_NOT_6110(#(NLSA))) ', 980, null, null, null, null, 0, 0, 0, 0, '0.2*#(S)', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0M', name='Нар.комiсії за пререрах.коштів на рах.акредит.нотаріуса', dk=1, nlsm='#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', kv=980, nlsk='#(BEZN_NOT_6110(#(NLSA))) ', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0.2*#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K0M';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K0M';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K0M';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K0M';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K0M';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K0M';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K0M';
end;
/
prompt Создание / Обновление операции 40M
prompt Наименование операции: 40M  Перерахування коштів на рах. акредит. нотаріуса (з коміс 20%) 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('40M', '40M  Перерахування коштів на рах. акредит. нотаріуса (з коміс 20%) ', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000010000000000000000000000000000', 'За надані послуги в рамках кредитного договору №____ від __________ ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='40M', name='40M  Перерахування коштів на рах. акредит. нотаріуса (з коміс 20%) ', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000010000000000000000000000000000', nazn='За надані послуги в рамках кредитного договору №____ від __________ '
       where tt='40M';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='40M';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D_CRD', '40M', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D_CRD'', ''40M'', ''M'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('N_CRD', '40M', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''N_CRD'', ''40M'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='40M';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('G0M', '40M', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''G0M'', ''40M'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K0M', '40M', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''K0M'', ''40M'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='40M';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', '40M', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''40M'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', '40M', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''40M'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', '40M', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''40M'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2650', '40M', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2650'', ''40M'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='40M';
  begin
    insert into tts_vob(vob, tt, ord)
    values (169, '40M', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 169, ''40M'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='40M';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '40M', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''40M'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '40M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''40M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='40M';
  begin
    insert into folders_tts(idfo, tt)
    values (91, '40M');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 91, ''40M'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
