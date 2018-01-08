set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 121
prompt Наименование операции: 121-Комісія іноземн.банку за іменні чеки прийняті до сплати на інкас
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('121', '121-Комісія іноземн.банку за іменні чеки прийняті до сплати на інкас', 1, '#(nbs_ob22 (''2622'',''01''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_6510B0'',0))', 980, null, '#(nbs_ob22 (''2622'',''01''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_6510B0'',0))', null, 0, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000000000000010000000000000000000000000000', 'Комісія іноземного банку за іменні чеки прийняті до сплати на інкасо');
  exception
    when dup_val_on_index then 
      update tts
         set tt='121', name='121-Комісія іноземн.банку за іменні чеки прийняті до сплати на інкас', dk=1, nlsm='#(nbs_ob22 (''2622'',''01''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_6510B0'',0))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''2622'',''01''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_6510B0'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000000000000010000000000000000000000000000', nazn='Комісія іноземного банку за іменні чеки прийняті до сплати на інкасо'
       where tt='121';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='121';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='121';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='121';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2622', '121', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2622'', ''121'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6110', '121', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6110'', ''121'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6510', '121', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6510'', ''121'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='121';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '121', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''121'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='121';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '121', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''121'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '121', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''121'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='121';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '121');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''121'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
