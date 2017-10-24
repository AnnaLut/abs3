set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ID6
prompt Наименование операции: ID6 - Зарахування стягнених дох в ВАЛ з РУ (доч. I11)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ID6', 'ID6 - Зарахування стягнених дох в ВАЛ з РУ (доч. I11)', 1, null, null, '#(GOU_RU(2))', 980, null, null, null, null, 0, 0, 1, 0, null, 'gl.p_icurval(#(KVA),#(S),bankdate)', null, null, '3800203', null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ID6', name='ID6 - Зарахування стягнених дох в ВАЛ з РУ (доч. I11)', dk=1, nlsm=null, kv=null, nlsk='#(GOU_RU(2))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2='gl.p_icurval(#(KVA),#(S),bankdate)', sk=null, proc=null, s3800='3800203', rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ID6';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ID6';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ID6';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ID6';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ID6';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ID6';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ID6';
end;
/
prompt Создание / Обновление операции I11
prompt Наименование операции: I11-МВПС Реальний ДЕБЕТ (стягн.дох.в ВАЛ з РУ)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('I11', 'I11-МВПС Реальний ДЕБЕТ (стягн.дох.в ВАЛ з РУ)', 0, null, null, '37398021', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '1200000000000000000000000000000000000000000000000000000000000000', 'Комісія за вивіз готівкової валюти.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='I11', name='I11-МВПС Реальний ДЕБЕТ (стягн.дох.в ВАЛ з РУ)', dk=0, nlsm=null, kv=null, nlsk='37398021', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1200000000000000000000000000000000000000000000000000000000000000', nazn='Комісія за вивіз готівкової валюти.'
       where tt='I11';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='I11';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='I11';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('ID6', 'I11', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''ID6'', ''I11'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='I11';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='I11';
  begin
    insert into tts_vob(vob, tt, ord)
    values (2, 'I11', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 2, ''I11'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='I11';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'I11', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''I11'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'I11', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''I11'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='I11';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'I11');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 70, ''I11'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
