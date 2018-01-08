set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PS4
prompt Наименование операции: PS4 Д/PS3 Перекрытие межбанковское
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PS4', 'PS4 Д/PS3 Перекрытие межбанковское', 1, null, 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 0, 1, 0, 0, '#(S)-F_TARIF(46, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0200100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PS4', name='PS4 Д/PS3 Перекрытие межбанковское', dk=1, nlsm=null, kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s='#(S)-F_TARIF(46, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0200100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='PS4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PS4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PS4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PS4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PS4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PS4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PS4';
end;
/
prompt Создание / Обновление операции PSK
prompt Наименование операции: PSK Д/PS3 КОМИСИЯ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PSK', 'PSK Д/PS3 КОМИСИЯ', 1, null, null, '#(nbs_ob22 (''6510'',''06''))', null, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(46, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PSK', name='PSK Д/PS3 КОМИСИЯ', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6510'',''06''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(46, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='PSK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PSK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PSK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PSK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PSK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PSK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PSK';
end;
/
prompt Создание / Обновление операции PS3
prompt Наименование операции: PS3 p) П-р Перекрытие межбанковское ГРН
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PS3', 'PS3 p) П-р Перекрытие межбанковское ГРН', 1, null, 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300100000000000000000000000000000000300000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PS3', name='PS3 p) П-р Перекрытие межбанковское ГРН', dk=1, nlsm=null, kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300100000000000000000000000000000000300000000000000000000000000', nazn=null
       where tt='PS3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PS3';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_K', 'PS3', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ASP_K'', ''PS3'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_N', 'PS3', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ASP_N'', ''PS3'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_S', 'PS3', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ASP_S'', ''PS3'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', 'PS3', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_B'', ''PS3'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', 'PS3', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''PS3'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', 'PS3', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''PS3'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PS3';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('PS4', 'PS3', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''PS4'', ''PS3'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('PSK', 'PS3', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''PSK'', ''PS3'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PS3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PS3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'PS3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''PS3'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PS3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PS3'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PS3';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'PS3', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''PS3'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (17, 'PS3', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 17, ''PS3'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PS3';
end;
/
commit;
