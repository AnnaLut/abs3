set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции UKS
prompt Наименование операции: Облік ощадної книжки(отримання з комори)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('UKS', 'Облік ощадної книжки(отримання з комори)', 1, null, 980, null, 980, null, null, '#(nbs_ob22 (''9893'',''31''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', 'Отрим. з комори ощад.книж.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='UKS', name='Облік ощадної книжки(отримання з комори)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''9893'',''31''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Отрим. з комори ощад.книж.'
       where tt='UKS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='UKS';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='UKS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='UKS';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9821', 'UKS', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9821'', ''UKS'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='UKS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, 'UKS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 206, ''UKS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='UKS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'UKS', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''UKS'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='UKS';
end;
/
commit;
