set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции IBL
prompt Наименование операции: IBL-Internet-Banking: ЕСКРОУ (повернення внутр)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IBL', 'IBL-Internet-Banking: ЕСКРОУ (повернення внутр)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', 'Повернення не використаних клієнтом коштів відповідно до реєстру невикористаних клієнтом коштів');
  exception
    when dup_val_on_index then
      update tts set
        tt='IBL', name='IBL-Internet-Banking: ЕСКРОУ (повернення внутр)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='Повернення не використаних клієнтом коштів відповідно до реєстру невикористаних клієнтом коштів'
       where tt='IBL';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='IBL';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IBL';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IBL';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2600', 'IBL', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''IBL'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2602', 'IBL', 0, '09');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2602'', ''IBL'', 0, ''09'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='IBL';
  begin
    insert into vob(VOB, NAME, FLV, REP_PREFIX)
    values (6, 'Меморiальний ордер', 1, 'MEMORD');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (6, 'IBL');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''IBL'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IBL';
  begin
    insert into chklist(idchk, name, comm)
    values (25, '25 Операціоніста Клієнт-Банк', null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (25, 'IBL', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 25, ''IBL'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='IBL';
  begin
    insert into folders(IDFO, NAME)
    values (25, 'Клієнт-банк (АВТО)');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (25, 'IBL');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 25, ''IBL'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
