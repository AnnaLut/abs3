set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции GOV
prompt Наименование операции: GOV --- Розрахунки за КУПІВЛЮ валюти через вал.позицію
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GOV', 'GOV --- Розрахунки за КУПІВЛЮ валюти через вал.позицію', 0, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', 980, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', null, 0, 0, 1, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GOV', name='GOV --- Розрахунки за КУПІВЛЮ валюти через вал.позицію', dk=0, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', kvk=980, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GOV';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='GOV';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='GOV';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='GOV';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='GOV';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'GOV', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''GOV'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='GOV';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'GOV', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''GOV'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='GOV';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GOV');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 20, ''GOV'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
