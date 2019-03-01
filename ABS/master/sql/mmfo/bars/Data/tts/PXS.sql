set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PXS
prompt Наименование операции: PXS-Виплата субсидії згідно ПКМУ від 21.10.1995 № 848
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PXS', 'PXS-Виплата субсидії згідно ПКМУ від 21.10.1995 № 848', 1, null, null, '#(bpk_get_transit(''1X'',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000001000000010000000000000000000000000000', 'Виплата субсидії згідно ПКМУ від 21.10.1995 № 848');
  exception
    when dup_val_on_index then 
      update tts
         set tt='PXS', name='PXS-Виплата субсидії згідно ПКМУ від 21.10.1995 № 848', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''1X'',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000001000000010000000000000000000000000000', nazn='Виплата субсидії згідно ПКМУ від 21.10.1995 № 848'
       where tt='PXS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PXS';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SK_ZB', 'PXS', 'O', 1, null, '87', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''SK_ZB'', ''PXS'', ''O'', 1, null, ''87'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PXS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PXS';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'PXS', 1, '36');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''PXS'', 1, ''36'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2909', 'PXS', 0, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2909'', ''PXS'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2924', 'PXS', 0, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''PXS'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PXS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PXS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PXS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PXS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'PXS', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''PXS'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'PXS', 2, null, 'bpk_visa30(ref, 1)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''PXS'', 2, null, ''bpk_visa30(ref, 1)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PXS';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'PXS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''PXS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
