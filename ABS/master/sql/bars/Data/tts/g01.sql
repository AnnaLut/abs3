prompt Создание / Обновление операции G01
prompt Наименование операции: G01 ГЕРЦ Касові 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G01', 'G01 ГЕРЦ Касові ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, '0', null, '0001100000000000000000000000000000110100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G01', name='G01 ГЕРЦ Касові ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0001100000000000000000000000000000110100000000000000000000000000', nazn=null
       where tt='G01';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='G01';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='G01';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='G01';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('100 ', 'G01', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''100 '', ''G01'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('290 ', 'G01', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''290 '', ''G01'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='G01';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'G01', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''G01'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G01';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='G01';
end;
/
commit;
