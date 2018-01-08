set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции D2W
prompt Наименование операции: D2W Перерахування коштів з депозитного рах. на транзит(2924)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D2W', 'D2W Перерахування коштів з депозитного рах. на транзит(2924)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000100000000000000000000000000', 'Зписання коштів на транзит');
  exception
    when dup_val_on_index then 
      update tts
         set tt='D2W', name='D2W Перерахування коштів з депозитного рах. на транзит(2924)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000100000000000000000000000000', nazn='Зписання коштів на транзит'
       where tt='D2W';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D2W';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D2W';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D2W';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2630', 'D2W', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2630'', ''D2W'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2635', 'D2W', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2635'', ''D2W'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2924', 'D2W', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''D2W'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D2W';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'D2W', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''D2W'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D2W';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D2W';
end;
/
commit;
