set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 834
prompt Наименование операции: 834d доч. до 845 (БМ=959)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('834', '834d доч. до 845 (БМ=959)', 1, null, null, '6204290007561', 980, null, null, null, null, 0, 0, 1, 0, '#(S)', 'GL.P_ICURVAL(#(KVA),#(S),SYSDATE)', null, null, '#(nbs_ob22 (''3800'',''09''))', null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='834', name='834d доч. до 845 (БМ=959)', dk=1, nlsm=null, kv=null, nlsk='6204290007561', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='#(S)', s2='GL.P_ICURVAL(#(KVA),#(S),SYSDATE)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''09''))', rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='834';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='834';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='834';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='834';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='834';
  begin
    insert into tts_vob(vob, tt, ord)
    values (13, '834', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 13, ''834'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='834';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '834', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''834'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '834', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''834'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='834';
  begin
    insert into folders_tts(idfo, tt)
    values (26, '834');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 26, ''834'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (92, '834');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 92, ''834'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
