set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ZMO
prompt Наименование операции: Зведений МО
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ZMO', 'Зведений МО', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000300000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ZMO', name='Зведений МО', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000300000000000000000000000000', nazn=null
       where tt='ZMO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ZMO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ZMO';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ZMO';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ZMO';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ZMO';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'ZMO', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''ZMO'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ZMO';
  begin
    insert into folders_tts(idfo, tt)
    values (92, 'ZMO');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 92, ''ZMO'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
