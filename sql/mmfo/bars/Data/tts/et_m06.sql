set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции M06
prompt Наименование операции: M06 Реалізація клієнтам юв.монет (облік на складі)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('M06', 'M06 Реалізація клієнтам юв.монет (облік на складі)', 1, '#(nbs_ob22 (''2909'',''23''))', 980, '#(nbs_ob22 (''3400'',''08''))', 980, null, '#(nbs_ob22 (''2909'',''23''))', '#(nbs_ob22 (''3400'',''08''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='M06', name='M06 Реалізація клієнтам юв.монет (облік на складі)', dk=1, nlsm='#(nbs_ob22 (''2909'',''23''))', kv=980, nlsk='#(nbs_ob22 (''3400'',''08''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''2909'',''23''))', nlsb='#(nbs_ob22 (''3400'',''08''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='M06';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='M06';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='M06';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='M06';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'M06', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''M06'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3400', 'M06', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3400'', ''M06'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='M06';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'M06', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''M06'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='M06';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'M06', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''M06'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='M06';
  begin
    insert into folders_tts(idfo, tt)
    values (89, 'M06');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 89, ''M06'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
