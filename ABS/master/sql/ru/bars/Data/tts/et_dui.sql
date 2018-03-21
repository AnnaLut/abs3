set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DU8
prompt Наименование операции: +Позасистемний облік депозитних ліній ЮО
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU8', '+Позасистемний облік депозитних ліній ЮО', 1, '#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', null, '#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', null, null, null, null, null, 0, 0, 0, 0, 'case when dpu.is_line(#(REF)) is null then 0 else #(S) end', null, null, null, null, 0, '1000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU8', name='+Позасистемний облік депозитних ліній ЮО', dk=1, nlsm='#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', kv=null, nlsk='#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='case when dpu.is_line(#(REF)) is null then 0 else #(S) end', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='1000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DU8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DU8';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DU8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DU8';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('8   ', 'DU8', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''8   '', ''DU8'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('8   ', 'DU8', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''8   '', ''DU8'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DU8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DU8';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DU8';
end;
/
prompt Создание / Обновление операции DUI
prompt Наименование операции: Виплата відсотків в ін.валюті (міжбанк ВПС)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DUI', 'Виплата відсотків в ін.валюті (міжбанк ВПС)', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, 9, '0300100000000000000000000000000000010000000000000000000000000000', 'Відсотки по депозиту згідно #{DPU.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DUI', name='Виплата відсотків в ін.валюті (міжбанк ВПС)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=9, flags='0300100000000000000000000000000000010000000000000000000000000000', nazn='Відсотки по депозиту згідно #{DPU.F_NAZN(''U'',#(ND))}'
       where tt='DUI';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DUI';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DUI', 'O', 0, 2, '47', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''DUI'', ''O'', 0, 2, ''47'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', 'DUI', 'O', 0, 3, '6', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_B'', ''DUI'', ''O'', 0, 3, ''6'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ND   ', 'DUI', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ND   '', ''DUI'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DUI';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DU8', 'DUI', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''DU8'', ''DUI'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DUI';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DUI';
  begin
    insert into tts_vob(vob, tt, ord)
    values (19, 'DUI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 19, ''DUI'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (46, 'DUI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 46, ''DUI'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DUI';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (3, 'DUI', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 3, ''DUI'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DUI', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DUI'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DUI';
  begin
    insert into folders_tts(idfo, tt)
    values (4, 'DUI');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 4, ''DUI'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
