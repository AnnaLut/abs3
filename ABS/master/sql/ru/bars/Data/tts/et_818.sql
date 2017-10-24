set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 809
prompt Наименование операции: 809 - Сума номіналу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('809', '809 - Сума номіналу', 1, null, null, '29003', null, null, null, null, null, 0, 0, 0, 0, '#(S)', '#(S)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='809', name='809 - Сума номіналу', dk=1, nlsm=null, kv=null, nlsk='29003', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2='#(S)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='809';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='809';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='809';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='809';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='809';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='809';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='809';
end;
/
prompt Создание / Обновление операции 818
prompt Наименование операции: 818-Купівля влас кош РУ(зарах.ВАЛ, спис.ГРН,без коміс)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('818', '818-Купівля влас кош РУ(зарах.ВАЛ, спис.ГРН,без коміс)', 0, null, null, null, 980, null, null, null, '300465', 1, 0, 1, 0, null, null, null, null, null, null, '1100000000000000000000000000000000010300000000000000000000010000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='818', name='818-Купівля влас кош РУ(зарах.ВАЛ, спис.ГРН,без коміс)', dk=0, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100000000000000000000000000000000010300000000000000000000010000', nazn=null
       where tt='818';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='818';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='818';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('809', '818', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''809'', ''818'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='818';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2900', '818', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2900'', ''818'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2900', '818', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2900'', ''818'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='818';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, '818', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''818'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='818';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '818', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''818'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '818', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''818'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='818';
end;
/
commit;
