set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции M08
prompt Наименование операции: M08 Визнання податк.зобов'язання (з ПДВ)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('M08', 'M08 Визнання податк.зобов''язання (з ПДВ)', 1, '#(nbs_ob22 (''2909'',''23''))', 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, '#(nbs_ob22 (''2909'',''23''))', '#(nbs_ob22 (''3622'',''51''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='M08', name='M08 Визнання податк.зобов''язання (з ПДВ)', dk=1, nlsm='#(nbs_ob22 (''2909'',''23''))', kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''2909'',''23''))', nlsb='#(nbs_ob22 (''3622'',''51''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='M08';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='M08';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='M08';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='M08';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'M08', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''M08'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3622', 'M08', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3622'', ''M08'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='M08';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'M08', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''M08'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='M08';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'M08', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''M08'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='M08';
  begin
    insert into folders_tts(idfo, tt)
    values (89, 'M08');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 89, ''M08'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
