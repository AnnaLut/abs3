set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции GOB
prompt Наименование операции: GOB БО: возврат излишков (межбанк)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GOB', 'GOB БО: возврат излишков (межбанк)', 1, null, null, '#(get_nls_tt(''GOB'',''NLSK''))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GOB', name='GOB БО: возврат излишков (межбанк)', dk=1, nlsm=null, kv=null, nlsk='#(get_nls_tt(''GOB'',''NLSK''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GOB';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='GOB';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='GOB';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='GOB';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='GOB';
  begin
    insert into tts_vob(vob, tt, ord)
    values (45, 'GOB', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 45, ''GOB'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='GOB';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'GOB', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''GOB'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='GOB';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GOB');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 20, ''GOB'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
