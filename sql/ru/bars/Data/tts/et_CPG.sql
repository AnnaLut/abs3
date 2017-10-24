set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CPG
prompt Наименование операции: CPG/ЦП. Робота з гарантіями та забепеченням
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CPG', 'CPG/ЦП. Робота з гарантіями та забепеченням', 1, '#(f_cp_9900)', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 10, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CPG', name='CPG/ЦП. Робота з гарантіями та забепеченням', dk=1, nlsm='#(f_cp_9900)', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=10, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CPG';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CPG';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CPG';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CPG';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CPG';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'CPG', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''CPG'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CPG';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CPG', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CPG'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CPG', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CPG'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CPG';
  begin
    insert into folders_tts(idfo, tt)
    values (13, 'CPG');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 13, ''CPG'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
