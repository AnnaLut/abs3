set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!3
prompt Наименование операции: :STOP ! МФОА=МФОБ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!3', ':STOP ! МФОА=МФОБ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(3,#(MFOA),'''',#(MFOB))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!3', name=':STOP ! МФОА=МФОБ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(3,#(MFOA),'''',#(MFOB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!3';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='!!3';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!3';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!3';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='!!3';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!3';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='!!3';
  
  
end;
/

prompt Создание / Обновление операции IBE
prompt Наименование операции: IBE-Internet-Banking:  ЕСКРОУ (СЕП)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IBE', 'IBE-Internet-Banking:  ЕСКРОУ (СЕП)', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '0301000000000000000000000000000000110000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='IBE', name='IBE-Internet-Banking:  ЕСКРОУ (СЕП)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0301000000000000000000000000000000110000000000000000000000000000', nazn=null
       where tt='IBE';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='IBE';
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV06', 'corp2: віза 6', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV07', 'corp2: віза 7', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV02', 'corp2: віза 2', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('EXREF', 'copr2: ID документу', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV04', 'corp2: віза 4', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV05', 'corp2: віза 5', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV01', 'corp2: віза 1', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV03', 'corp2: віза 3', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('ATRT ', 'Ким і коли видано документ', null, 'TagBrowse("SELECT name, id FROM organdok order by name")', null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV08', 'corp2: віза 8', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBV09', 'corp2: віза 9', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('IBTIM', 'corp2: Час створення', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('PASP ', 'Документ', null, 'TagBrowse("SELECT name,passp FROM passp order by passp")', null, null, 'C_TAG( #(TAG), #(VAL) )');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('D    ', 'Дата валютування в СЕП(ГГММДД)', null, null, null, 'D', 'C_TAG( #(TAG), #(VAL) )');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_field(tag, name, fmt, browser, nomodify, vspo_char, chkr)
    values ('PASPN', 'Серія і номер документу', null, null, null, null, null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ATRT '', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D    ', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D    '', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('EXREF', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''EXREF'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBTIM', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBTIM'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV01', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV01'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV02', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV02'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV03', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV03'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV04', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV04'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV05', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV05'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV06', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV06'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV07', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV07'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV08', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV08'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV09', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV09'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP '', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'IBE', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''IBE'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IBE';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!3', 'IBE', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!!3'', ''IBE'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IBE';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='IBE';
  begin
    insert into vob(VOB, NAME, FLV, REP_PREFIX)
    values (6, 'Меморiальний ордер', 1, 'MEMORD');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (6, 'IBE');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''IBE'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IBE';
  begin
    insert into chklist(idchk, name, comm)
    values (25, '25 Операціоніста Клієнт-Банк', null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (25, 'IBE', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 25, ''IBE'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='IBE';
  begin
    insert into folders(IDFO, NAME)
    values (25, 'Клієнт-банк (АВТО)');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (25, 'IBE');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 25, ''IBE'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
