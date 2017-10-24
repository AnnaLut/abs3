set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SC1
prompt Наименование операции: Плата за РКО при надходженні безготівкових коштів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SC1', 'Плата за РКО при надходженні безготівкових коштів', 0, null, 980, null, 980, null, '#(tobopack.GetTOBOParam(''SOC_096''))', null, null, 0, 0, 0, 0, null, null, 16, null, null, null, '0000100001000000000000000000000000000000000000000000000000000000', 'Плата за РКО при надходженні безготівкових коштів. Без ПДВ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SC1', name='Плата за РКО при надходженні безготівкових коштів', dk=0, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(tobopack.GetTOBOParam(''SOC_096''))', nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=16, proc=null, s3800=null, rang=null, flags='0000100001000000000000000000000000000000000000000000000000000000', nazn='Плата за РКО при надходженні безготівкових коштів. Без ПДВ'
       where tt='SC1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SC1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SC1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SC1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'SC1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''SC1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SC1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SC1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SC1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SC1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'SC1', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''SC1'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SC1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''SC1'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SC1';
  begin
    insert into folders_tts(idfo, tt)
    values (5, 'SC1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 5, ''SC1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
