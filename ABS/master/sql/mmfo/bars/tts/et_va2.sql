set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VA2
prompt Наименование операции: VA2 Здача Цiнностей з "пiд звiт"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VA2', 'VA2 Здача Цiнностей з "пiд звiт"', 0, null, 980, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', 980, null, null, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VA2', name='VA2 Здача Цiнностей з "пiд звiт"', dk=0, nlsm=null, kv=980, nlsk='#(branch_usr.get_branch_param2(''NLS_9910'',0))', kvk=980, nlss=null, nlsa=null, nlsb='#(branch_usr.get_branch_param2(''NLS_9910'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='VA2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VA2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VA2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VA2';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9812', 'VA2', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9812'', ''VA2'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9819', 'VA2', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9819'', ''VA2'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VA2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (981, 'VA2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 981, ''VA2'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VA2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'VA2', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''VA2'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VA2';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VA2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VA2'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
