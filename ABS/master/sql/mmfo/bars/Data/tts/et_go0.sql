set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции GO0
prompt Наименование операции: --- Розрахунки за ПРОДАЖ валюти через вал.позицію
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GO0', '--- Розрахунки за ПРОДАЖ валюти через вал.позицію', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', 980, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', null, 0, 0, 1, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GO0', name='--- Розрахунки за ПРОДАЖ валюти через вал.позицію', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', kvk=980, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GO0';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='GO0';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='GO0';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='GO0';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='GO0';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'GO0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''GO0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='GO0';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'GO0', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''GO0'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='GO0';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GO0');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 20, ''GO0'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
