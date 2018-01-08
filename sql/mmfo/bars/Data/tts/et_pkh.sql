set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PKH
prompt Наименование операции: PKH-Плата за обслуговування БПК / 35(2О)-Плата за дод.послуги
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PKH', 'PKH-Плата за обслуговування БПК / 35(2О)-Плата за дод.послуги', 1, '#(bpk_get_transit(''2O'',#(NLSB),#(NLSA),#(KVA)))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000010000000010010000000000000000000000001', 'Плата за обслуговування БПК');
  exception
    when dup_val_on_index then 
      update tts
         set tt='PKH', name='PKH-Плата за обслуговування БПК / 35(2О)-Плата за дод.послуги', dk=1, nlsm='#(bpk_get_transit(''2O'',#(NLSB),#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000010000000010010000000000000000000000001', nazn='Плата за обслуговування БПК'
       where tt='PKH';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PKH';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SK_ZB', 'PKH', 'O', 0, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''SK_ZB'', ''PKH'', ''O'', 0, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PKH';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PKH';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2605', 'PKH', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2605'', ''PKH'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3570', 'PKH', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3570'', ''PKH'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PKH';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PKH', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PKH'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PKH';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'PKH', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''PKH'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PKH';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'PKH');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''PKH'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
