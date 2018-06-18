set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции IF3
prompt Наименование операции: IF3-Рекласифікація активів на 01.04.2018
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IF3', 'IF3-Рекласифікація активів на 01.04.2018', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22(''3800'',nvl(F_DOP(null,''OB22''),''03''))) ', null, '1101101000000000000000000001000000010000000000000000000000000000', 'Рекласифікація активів на 01.04.2018');
  exception
    when dup_val_on_index then 
      update tts
         set tt='IF3', name='IF3-Рекласифікація активів на 01.04.2018', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22(''3800'',nvl(F_DOP(null,''OB22''),''03''))) ', rang=null, flags='1101101000000000000000000001000000010000000000000000000000000000', nazn='Рекласифікація активів на 01.04.2018'
       where tt='IF3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='IF3';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OB22 ', 'IF3', 'O', 1, 0, '03', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OB22 '', ''IF3'', ''O'', 1, 0, ''03'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IF3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IF3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='IF3';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IF3';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'IF3', 2, null, null, 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''IF3'', 2, null, null, 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'IF3', 1, null, null, 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''IF3'', 1, null, null, 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='IF3';
end;
/
commit;
