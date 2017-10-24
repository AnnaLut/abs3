set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 931
prompt Наименование операции: 931d (дочірня до операції 431)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('931', '931d (дочірня до операції 431)', 1, '#(nbs_ob22 (''9615'',''02''))', null, '#(nbs_ob22 (''9910'',''01''))', null, null, null, null, null, 0, 0, 0, 1, null, null, null, null, null, null, '0101100000000000000000000000000000010000000000000000000000000000', 'Списання безнадійної дебіторської заборгованості за операціями з клієнтами за рахунок спец.резерву');
  exception
    when dup_val_on_index then 
      update tts
         set tt='931', name='931d (дочірня до операції 431)', dk=1, nlsm='#(nbs_ob22 (''9615'',''02''))', kv=null, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101100000000000000000000000000000010000000000000000000000000000', nazn='Списання безнадійної дебіторської заборгованості за операціями з клієнтами за рахунок спец.резерву'
       where tt='931';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='931';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='931';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='931';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='931';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='931';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='931';
end;
/
prompt Создание / Обновление операции 431
prompt Наименование операции: 431 Списання безнадійної заборг-ті за опер з клієнтами за рах спецрез.
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('431', '431 Списання безнадійної заборг-ті за опер з клієнтами за рах спецрез.', 1, null, null, null, null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1101100000000000000000000000000000010000000000000000000000000000', 'Списання безнадійної дебіторської заборгованості за операціями з клієнтами за рахунок спец.резерву');
  exception
    when dup_val_on_index then 
      update tts
         set tt='431', name='431 Списання безнадійної заборг-ті за опер з клієнтами за рах спецрез.', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1101100000000000000000000000000000010000000000000000000000000000', nazn='Списання безнадійної дебіторської заборгованості за операціями з клієнтами за рахунок спец.резерву'
       where tt='431';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='431';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='431';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('931', '431', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''931'', ''431'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='431';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2800', '431', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2800'', ''431'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2801', '431', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2801'', ''431'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2809', '431', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2809'', ''431'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2890', '431', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2890'', ''431'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='431';
  begin
    insert into tts_vob(vob, tt, ord)
    values (50, '431', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 50, ''431'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='431';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '431', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''431'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '431', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''431'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='431';
  begin
    insert into folders_tts(idfo, tt)
    values (44, '431');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 44, ''431'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
