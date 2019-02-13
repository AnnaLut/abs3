set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции RXP
prompt Наименование операции: RXP ЦП: Переоцінка
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('RXP', 'RXP ЦП: Переоцінка за рахунок резерву', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(get_nls_tt(''RXP'',''S3800''))', null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='RXP', name='RXP ЦП: Переоцінка', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(get_nls_tt(''RXP'',''S3800''))', rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='RXP';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='RXP';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='RXP';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='RXP';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='RXP';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='RXP';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'RXP', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''RXP'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'RXP', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''RXP'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='RXP';
end;
/
commit;
