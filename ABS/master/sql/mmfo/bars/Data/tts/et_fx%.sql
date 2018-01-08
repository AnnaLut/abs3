set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции FX%
prompt Наименование операции: FX% ЦБ: Нарах.купону
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FX%', 'FX% ЦБ: Нарах.купону', 1, null, null, null, 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000000000000000000000000000000000010000000000000000000000000000', '#{BARS.F_NAZN_FX(''CP'',''#(NLS)'',''#(KV)'',''#(NLSA)'',''#(KVA)'')} з #(DAT1) по #(DAT2) вкл.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='FX%', name='FX% ЦБ: Нарах.купону', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000000000000000000000000000000000010000000000000000000000000000', nazn='#{BARS.F_NAZN_FX(''CP'',''#(NLS)'',''#(KV)'',''#(NLSA)'',''#(KVA)'')} з #(DAT1) по #(DAT2) вкл.'
       where tt='FX%';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='FX%';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CP_IN', 'FX%', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CP_IN'', ''FX%'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CP_MR', 'FX%', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CP_MR'', ''FX%'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='FX%';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='FX%';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='FX%';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'FX%', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''FX%'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='FX%';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'FX%', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''FX%'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'FX%', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''FX%'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='FX%';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'FX%');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''FX%'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
