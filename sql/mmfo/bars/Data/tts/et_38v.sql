set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 38V
prompt Наименование операции: 38V Пiдкрiплення Валютної Позицiї
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('38V', '38V Пiдкрiплення Валютної Позицiї', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(pul.Get_Mas_Ini_Val(''VP''))', null, '0000100000000000000000000000000000010000000000000000000000010000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='38V', name='38V Пiдкрiплення Валютної Позицiї', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(pul.Get_Mas_Ini_Val(''VP''))', rang=null, flags='0000100000000000000000000000000000010000000000000000000000010000', nazn=null
       where tt='38V';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='38V';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KURS ', '38V', 'M', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KURS '', ''38V'', ''M'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='38V';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='38V';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='38V';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, '38V', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''38V'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='38V';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '38V', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''38V'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='38V';
  begin
    insert into folders_tts(idfo, tt)
    values (29, '38V');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 29, ''38V'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
