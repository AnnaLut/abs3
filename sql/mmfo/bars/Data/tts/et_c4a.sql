set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции C4A
prompt Наименование операции: C4A(доч.CN4) Комісія банку за прийом переказу в ГРН
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C4A', 'C4A(доч.CN4) Комісія банку за прийом переказу в ГРН', 1, '#(swi_get_acc(''7509''))', 980, '#(swi_get_acc(''2809''))', 980, null, null, null, null, 1, 0, 0, 0, 'f_swi_sum(1)', 'f_swi_sum(1)', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C4A', name='C4A(доч.CN4) Комісія банку за прийом переказу в ГРН', dk=1, nlsm='#(swi_get_acc(''7509''))', kv=980, nlsk='#(swi_get_acc(''2809''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s='f_swi_sum(1)', s2='f_swi_sum(1)', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C4A';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='C4A';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='C4A';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='C4A';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='C4A';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='C4A';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'C4A', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''C4A'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'C4A', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''C4A'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='C4A';
end;
/
commit;
