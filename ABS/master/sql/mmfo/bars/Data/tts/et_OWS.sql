set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции OWS
prompt Наименование операции: OWS W4. Зарахування на карткові рахунки (СБОН)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWS', 'OWS W4. Зарахування на карткові рахунки (СБОН)', 1, null, null, '#(bpk_get_transit('''',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0001100000010000000000000000000000010000000000000000000000000000', '');
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWS', name='OWS W4. Зарахування на карткові рахунки (СБОН)', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit('''',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000010000000000000000000000010000000000000000000000000000', nazn=''
       where tt='OWS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OWS';

  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OWS';

  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OWS';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'OWS', 0, '');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''OWS'', 0, ''26'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2600', 'OWS', 1, '14');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''OWS'', 0, ''14'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
    begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'OWS', 1, '36');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''OWS'', 0, ''36'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OWS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OWS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''OWS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OWS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (16, 'OWS', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 16, ''OWS'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'OWS', 2, null, 'bpk_visa30(ref, 1)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''OWS'', 2, null, ''bpk_visa30(ref, 1)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OWS';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'OWS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''OWS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
