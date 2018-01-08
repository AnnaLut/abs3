set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции D3N
prompt Наименование операции: D3N-Встановлення винної особи за нестачами готівки
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D3N', 'D3N-Встановлення винної особи за нестачами готівки', 1, null, 980, '#(nbs_ob22 (''6399'',''D2''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000000000000000000000000000000000000000000', 'Встановлення винної особи за нестачами готівки');
  exception
    when dup_val_on_index then 
      update tts
         set tt='D3N', name='D3N-Встановлення винної особи за нестачами готівки', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6399'',''D2''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000000000000000000000000000000000000000000', nazn='Встановлення винної особи за нестачами готівки'
       where tt='D3N';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D3N';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D3N';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D3N';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3552', 'D3N', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3552'', ''D3N'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D3N';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'D3N', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''D3N'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D3N';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'D3N', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''D3N'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'D3N', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''D3N'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D3N';
  begin
    insert into folders_tts(idfo, tt)
    values (8, 'D3N');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 8, ''D3N'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (16, 'D3N');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 16, ''D3N'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
