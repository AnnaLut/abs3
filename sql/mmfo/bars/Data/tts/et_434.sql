set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 434
prompt Наименование операции: 434-Списання з позабал суми безнад.деб заборг,погаш або списаної у зб
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('434', '434-Списання з позабал суми безнад.деб заборг,погаш або списаної у зб', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 1, null, null, null, null, null, null, '1100100000000000000000000000000000010000000000000000000000000000', 'Списання з позабалансу суми безнадійної дебіторської заборгованості, погашеної або списаної у збиток');
  exception
    when dup_val_on_index then 
      update tts
         set tt='434', name='434-Списання з позабал суми безнад.деб заборг,погаш або списаної у зб', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100100000000000000000000000000000010000000000000000000000000000', nazn='Списання з позабалансу суми безнадійної дебіторської заборгованості, погашеної або списаної у збиток'
       where tt='434';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='434';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='434';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='434';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9615', '434', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9615'', ''434'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', '434', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9910'', ''434'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='434';
  begin
    insert into tts_vob(vob, tt, ord)
    values (207, '434', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 207, ''434'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='434';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '434', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''434'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '434', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''434'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='434';
  begin
    insert into folders_tts(idfo, tt)
    values (44, '434');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 44, ''434'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
