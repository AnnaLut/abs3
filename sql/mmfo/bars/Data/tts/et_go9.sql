set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции GO9
prompt Наименование операции: GO9 БО: Перекази в ГРН
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GO9', 'GO9 БО: Перекази в ГРН', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GO9', name='GO9 БО: Перекази в ГРН', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GO9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='GO9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='GO9';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='GO9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='GO9';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'GO9', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''GO9'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='GO9';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'GO9', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''GO9'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='GO9';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GO9');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 20, ''GO9'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
