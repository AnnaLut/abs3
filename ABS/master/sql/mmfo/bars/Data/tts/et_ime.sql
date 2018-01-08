set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции IME
prompt Наименование операции: IME Импорт файлов типа $A - внешняя операция
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IME', 'IME Импорт файлов типа $A - внешняя операция', 1, null, null, '#(get_nls_tt(''IME'',''NLSK'',p_kva=>#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='IME', name='IME Импорт файлов типа $A - внешняя операция', dk=1, nlsm=null, kv=null, nlsk='#(get_nls_tt(''IME'',''NLSK'',p_kva=>#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='IME';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='IME';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IME';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IME';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='IME';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'IME', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''IME'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IME';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'IME', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''IME'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'IME', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''IME'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='IME';
end;
/
commit;
