set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W2D
prompt Наименование операции: Перерахування коштів з транзиту(2924) на депозитний рах.
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W2D', 'Перерахування коштів з транзиту(2924) на депозитний рах.', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000100000000000000000000000000', 'Зарахування коштів на депозитний рахунок');
  exception
    when dup_val_on_index then 
      update tts
         set tt='W2D', name='Перерахування коштів з транзиту(2924) на депозитний рах.', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000100000000000000000000000000', nazn='Зарахування коштів на депозитний рахунок'
       where tt='W2D';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='W2D';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W2D';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W2D';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2630', 'W2D', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2630'', ''W2D'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2635', 'W2D', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2635'', ''W2D'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2924', 'W2D', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''W2D'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='W2D';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'W2D', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''W2D'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W2D';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='W2D';
end;
/
commit;
