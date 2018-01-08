set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KL6
prompt Наименование операции: Зарахування по даті валютування
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KL6', 'Зарахування по даті валютування', 1, '#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_klf2', null, null, null, null, 0, '0000000000000000000000100000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KL6', name='Зарахування по даті валютування', dk=1, nlsm='#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_klf2', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000000000000000000000100000000000000000000000000000000000000000', nazn=null
       where tt='KL6';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KL6';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KL6';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KL6';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KL6';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KL6';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KL6';
end;
/
prompt Создание / Обновление операции KL1
prompt Наименование операции: Внут.М/В платежi по "Клiєнт-Банк"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KL1', 'Внут.М/В платежi по "Клiєнт-Банк"', 1, null, null, '#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KL1', name='Внут.М/В платежi по "Клiєнт-Банк"', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='KL1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KL1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KL1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KL6', 'KL1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''KL6'', ''KL1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KL1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KL1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'KL1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''KL1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KL1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''KL1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KL1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'KL1', 7, null, 'substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''KL1'', 7, null, ''substr(NLSA,1,4) not in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'KL1', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''KL1'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, 'KL1', 4, null, '(((substr(nlsa,1,4) in (''2600'',''2650'',''2603'',''2530'',''2541'',''2542'',''2544'',''2545'')) and nvl(f_get_ob22(kv, nlsb), ''02'')=''04'' and kv=980 and substr(nlsb,1,4)=''1919'') or kv<>980)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 7, ''KL1'', 4, null, ''(((substr(nlsa,1,4) in (''''2600'''',''''2650'''',''''2603'''',''''2530'''',''''2541'''',''''2542'''',''''2544'''',''''2545'''')) and nvl(f_get_ob22(kv, nlsb), ''''02'''')=''''04'''' and kv=980 and substr(nlsb,1,4)=''''1919'''') or kv<>980)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'KL1', 6, null, 'substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''KL1'', 6, null, ''substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (38, 'KL1', 5, null, '( NLSA like ''20%'' or NLSA like ''21%'' or NLSA like ''22%'' )', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 38, ''KL1'', 5, null, ''( NLSA like ''''20%'''' or NLSA like ''''21%'''' or NLSA like ''''22%'''' )'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (62, 'KL1', 1, null, 'corp_visa_cond(ref, pdat, kv, s, mfoa, nlsa, id_a, mfob, nlsb, id_b)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 62, ''KL1'', 1, null, ''corp_visa_cond(ref, pdat, kv, s, mfoa, nlsa, id_a, mfob, nlsb, id_b)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KL1';
  begin
    insert into folders_tts(idfo, tt)
    values (25, 'KL1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 25, ''KL1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
