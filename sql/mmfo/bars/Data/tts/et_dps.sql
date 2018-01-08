set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DPS
prompt Наименование операции: DPS Стягнення штрафу при достроковому розірванні вкладу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DPS', 'DPS Стягнення штрафу при достроковому розірванні вкладу', 1, null, null, null, 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', 0, '0000100000000000000000000000000000010000000000000000000000000000', 'Повернення нарахованих, але не сплачених відсотків при достроковому розірванні договору #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DPS', name='DPS Стягнення штрафу при достроковому розірванні вкладу', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=0, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn='Повернення нарахованих, але не сплачених відсотків при достроковому розірванні договору #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DPS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DPS';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DPS', 'O', 0, 1, '5', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''DPS'', ''O'', 0, 1, ''5'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TTOF1', 'DPS', 'O', 0, null, '-102', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TTOF1'', ''DPS'', ''O'', 0, null, ''-102'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DPS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DPS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DPS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DPS', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''DPS'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (46, 'DPS', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 46, ''DPS'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DPS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DPS', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''DPS'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DPS', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DPS'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DPS';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DPS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''DPS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
