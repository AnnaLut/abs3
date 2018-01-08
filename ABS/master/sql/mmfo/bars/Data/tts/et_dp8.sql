set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KD4
prompt Наименование операции: KD4 Комiсiя за переказ відсотків
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD4', 'KD4 Комiсiя за переказ відсотків', 1, null, null, '#(nbs_ob22 (''6510'',''09''))', null, null, null, '#(nbs_ob22 (''6510'',''09''))', null, 0, 0, 0, 0, 'F_TARIF(23, #(KVA),#(NLSA), #(NOM))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD4', name='KD4 Комiсiя за переказ відсотків', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6510'',''09''))', kvk=null, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6510'',''09''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(23, #(KVA),#(NLSA), #(NOM))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KD4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KD4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KD4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KD4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KD4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KD4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KD4';
end;
/
prompt Создание / Обновление операции DP8
prompt Наименование операции: DP8 Виплата відсотків в нац.валюті (міжбанк) з комісією
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DP8', 'DP8 Виплата відсотків в нац.валюті (міжбанк) з комісією', 1, null, 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 1, 1, 0, 0, '#(NOM)-F_TARIF(23, #(KVA),#(NLSA), #(NOM))', null, null, null, null, 0, '0200100000000000000000000000000000010000000000000000000000100000', 'Виплата відсотків згідно договору № #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DP8', name='DP8 Виплата відсотків в нац.валюті (міжбанк) з комісією', dk=1, nlsm=null, kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s='#(NOM)-F_TARIF(23, #(KVA),#(NLSA), #(NOM))', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0200100000000000000000000000000000010000000000000000000000100000', nazn='Виплата відсотків згідно договору № #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DP8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DP8';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DP8', 'O', 0, 1, '46', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''DP8'', ''O'', 0, 1, ''46'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TTOF1', 'DP8', 'O', 0, null, 'KBH', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TTOF1'', ''DP8'', ''O'', 0, null, ''KBH'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('Ф    ', 'DP8', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''Ф    '', ''DP8'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ф    ', 'DP8', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ф    '', ''DP8'', ''O'', 1, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('П    ', 'DP8', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''П    '', ''DP8'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DP8';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KD4', 'DP8', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''KD4'', ''DP8'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DP8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DP8';
  begin
    insert into tts_vob(vob, tt, ord)
    values (164, 'DP8', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 164, ''DP8'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DP8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DP8', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''DP8'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DP8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DP8'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DP8';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DP8');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''DP8'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
