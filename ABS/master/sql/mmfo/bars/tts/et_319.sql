set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 319
prompt Наименование операции: 319 Закриття кред. заборгованості з НБУ та ін.банками за роз
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('319', '319 Закриття кред. заборгованості з НБУ та ін.банками за роз', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1309100000000000000000000001000000010000000000000000000000000000', 'Закриття кредиторської заборгованості з НБУ та іншими банками за розрахунками з готівкою');
  exception
    when dup_val_on_index then 
      update tts
         set tt='319', name='319 Закриття кред. заборгованості з НБУ та ін.банками за роз', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1309100000000000000000000001000000010000000000000000000000000000', nazn='Закриття кредиторської заборгованості з НБУ та іншими банками за розрахунками з готівкою'
       where tt='319';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='319';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='319';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='319';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1811', '319', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1811'', ''319'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1911', '319', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1911'', ''319'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='319';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '319', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''319'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='319';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '319', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''319'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='319';
  begin
    insert into folders_tts(idfo, tt)
    values (26, '319');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''319'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
