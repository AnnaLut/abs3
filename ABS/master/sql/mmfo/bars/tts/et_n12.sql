set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции N12
prompt Наименование операции: N12  Комісія з неактивного рахунку 2620/05
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('N12', 'N12  Комісія з неактивного рахунку 2620/05', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0101100000000000000000000001000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='N12', name='N12  Комісія з неактивного рахунку 2620/05', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0101100000000000000000000001000000010100000000000000000000000000', nazn=null
       where tt='N12';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='N12';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='N12';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='N12';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='N12';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'N12', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''N12'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='N12';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'N12', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''N12'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='N12';
  begin
    insert into folders_tts(idfo, tt)
    values (92, 'N12');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 92, ''N12'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
