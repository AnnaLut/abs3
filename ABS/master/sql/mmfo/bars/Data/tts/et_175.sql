set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 175
prompt Наименование операции: 175-Відправка дорожніх чеків
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('175', '175-Відправка дорожніх чеків', 1, '#(get_nls_tt(''175'',''NLSM''))', null, '#(nbs_ob22 (''9830'',''01''))', null, null, '#(get_nls_tt(''175'',''NLSA''))', '#(nbs_ob22 (''9830'',''01''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '1100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='175', name='175-Відправка дорожніх чеків', dk=1, nlsm='#(get_nls_tt(''175'',''NLSM''))', kv=null, nlsk='#(nbs_ob22 (''9830'',''01''))', kvk=null, nlss=null, nlsa='#(get_nls_tt(''175'',''NLSA''))', nlsb='#(nbs_ob22 (''9830'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='175';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='175';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PIDST', '175', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PIDST'', ''175'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SUMGD', '175', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''SUMGD'', ''175'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='175';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='175';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='175';
  begin
    insert into tts_vob(vob, tt, ord)
    values (207, '175', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 207, ''175'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='175';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '175', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''175'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '175', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''175'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='175';
  begin
    insert into folders_tts(idfo, tt)
    values (16, '175');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 16, ''175'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
