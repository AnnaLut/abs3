set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K09
prompt Наименование операции: K09 Комісія за виплату коштів з депозиту що надійшли безготівковим шля
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K09', 'K09 Комісія за виплату коштів з депозиту що надійшли безготівковим шля', 1, null, null, '#(nbs_ob22 (''6510'',''28''))', 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', 'Сплата комісії за виплату коштів що надійшли безготівковим шляхомпо з депозитного договору №#{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K09', name='K09 Комісія за виплату коштів з депозиту що надійшли безготівковим шля', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6510'',''28''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Сплата комісії за виплату коштів що надійшли безготівковим шляхомпо з депозитного договору №#{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='K09';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K09';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K09';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K09';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K09';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'K09', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''K09'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K09';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'K09', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''K09'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'K09', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''K09'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K09';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'K09');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''K09'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
