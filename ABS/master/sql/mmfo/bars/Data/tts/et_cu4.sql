set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CU4
prompt Наименование операции: CU4 Комісія банку за приймання переказу ЮНІСТРІМ (залишок)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CU4', 'CU4 Комісія банку за приймання переказу ЮНІСТРІМ (залишок)', 1, '#(nbs_ob22 (''2909'',''69''))', 980, '#(nbs_ob22 (''6510'',''B6''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0101100000000000000000000001000000010000000000000000000000000000', 'Комісія банку за прийом переказу (залишок), що належить установі банку');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CU4', name='CU4 Комісія банку за приймання переказу ЮНІСТРІМ (залишок)', dk=1, nlsm='#(nbs_ob22 (''2909'',''69''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B6''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101100000000000000000000001000000010000000000000000000000000000', nazn='Комісія банку за прийом переказу (залишок), що належить установі банку'
       where tt='CU4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CU4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CU4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CU4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CU4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''CU4'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6110', 'CU4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6110'', ''CU4'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CU4';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'CU4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''CU4'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CU4';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CU4', 2, null, 'f_universal_box2(USERID)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CU4'', 2, null, ''f_universal_box2(USERID)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CU4', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CU4'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CU4';
  begin
    insert into folders_tts(idfo, tt)
    values (42, 'CU4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 42, ''CU4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
