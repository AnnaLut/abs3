set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 82K
prompt Наименование операции: 82K(d)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('82K', '82K(d)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, '#(S)/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='82K', name='82K(d)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='82K';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='82K';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='82K';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='82K';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='82K';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='82K';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='82K';
end;
/
prompt Создание / Обновление операции 82P
prompt Наименование операции: 82P(d)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('82P', '82P(d)', 1, null, null, '64992010301017', null, null, null, null, null, 0, 0, 0, 0, '#(S)-#(S)/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='82P', name='82P(d)', dk=1, nlsm=null, kv=null, nlsk='64992010301017', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='82P';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='82P';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='82P';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='82P';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='82P';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='82P';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='82P';
end;
/
prompt Создание / Обновление операции 820
prompt Наименование операции: 820-Нарахування за надані послуги
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('820', '820-Нарахування за надані послуги', 1, null, 980, '36228051', 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000100000000001000000000001000000010300000000000000000000000000', 'Нарахування за надані послуги');
  exception
    when dup_val_on_index then 
      update tts
         set tt='820', name='820-Нарахування за надані послуги', dk=1, nlsm=null, kv=980, nlsk='36228051', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000001000000000001000000010300000000000000000000000000', nazn='Нарахування за надані послуги'
       where tt='820';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='820';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='820';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('82K', '820', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''82K'', ''820'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('82P', '820', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''82P'', ''820'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='820';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3519', '820', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3519'', ''820'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3619', '820', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3619'', ''820'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3622', '820', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3622'', ''820'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='820';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '820', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''820'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (138, '820', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 138, ''820'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  --------------------------------
  ------------- Папки ------------
  --------------------------------
end;
/
commit;
