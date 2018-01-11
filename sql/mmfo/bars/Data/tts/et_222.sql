set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 222
prompt Наименование операции: 222 Оприбуткування надлишків готівки (ВАЛ)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('222', '222 Оприбуткування надлишків готівки (ВАЛ)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, '#(NBS_OB22(''6399'',''01''))', 980, null, '#(get_nls_tt(''222'',''NLSA''))', '#(NBS_OB22(''6399'',''01''))', null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0001100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='222', name='222 Оприбуткування надлишків готівки (ВАЛ)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=null, nlsk='#(NBS_OB22(''6399'',''01''))', kvk=980, nlss=null, nlsa='#(get_nls_tt(''222'',''NLSA''))', nlsb='#(NBS_OB22(''6399'',''01''))', mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0001100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='222';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='222';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='222';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='222';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='222';
  begin
    insert into tts_vob(vob, tt, ord)
    values (21, '222', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 21, ''222'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='222';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '222', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''222'', 3, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '222', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''222'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='222';
  begin
    insert into folders_tts(idfo, tt)
    values (16, '222');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 16, ''222'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
