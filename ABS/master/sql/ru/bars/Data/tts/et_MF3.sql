set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MF3
prompt Наименование операции: MF3 Оприбуткування футлярів для юв.монет на суму ПДВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MF3', 'MF3 Оприбуткування футлярів для юв.монет на суму ПДВ', 1, '#(nbs_ob22 (''3522'',''51''))', 980, '#(nbs_ob22 (''1819'',''03''))', 980, null, '#(nbs_ob22 (''3522'',''51''))', '#(nbs_ob22 (''1819'',''03''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MF3', name='MF3 Оприбуткування футлярів для юв.монет на суму ПДВ', dk=1, nlsm='#(nbs_ob22 (''3522'',''51''))', kv=980, nlsk='#(nbs_ob22 (''1819'',''03''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''3522'',''51''))', nlsb='#(nbs_ob22 (''1819'',''03''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MF3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MF3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MF3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MF3';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1819', 'MF3', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1819'', ''MF3'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3522', 'MF3', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3522'', ''MF3'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MF3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'MF3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''MF3'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MF3';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MF3', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''MF3'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MF3';
  begin
    insert into folders_tts(idfo, tt)
    values (89, 'MF3');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 89, ''MF3'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
