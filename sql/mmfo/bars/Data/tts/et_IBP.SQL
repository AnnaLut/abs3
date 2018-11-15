set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции IBC
prompt Наименование операции: Дочірня для IBP (списання комісії)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IBC', 'Дочірня для IBP (списання комісії)', 1, '#(#(NLSA))', 980, '#(nbs_ob22_3570 (''3570'',''59'',#(NLSA),980))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(1000, #(KVA),#(NLSA), #(S))', null, null, 0, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='IBC', name='Дочірня для IBP (списання комісії)', dk=1, nlsm='#(#(NLSA))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''59'',#(NLSA),980))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(1000, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=0, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='IBC';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='IBC';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IBC';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IBC';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='IBC';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IBC';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='IBC';
  
  
end;
/

prompt Создание / Обновление операции IBK
prompt Наименование операции: Дочірня для IBP (нарахування комісії)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IBK', 'Дочірня для IBP (нарахування комісії)', 1, '#(nbs_ob22_3570 (''3570'',''59'',#(NLSA),980))', 980, '#(nbs_ob22 (''6510'',''H3''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(1000, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='IBK', name='Дочірня для IBP (нарахування комісії)', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''59'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6510'',''H3''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(1000, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='IBK';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='IBK';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IBK';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IBK';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='IBK';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IBK';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='IBK';
  
  
end;
/

prompt Создание / Обновление операции IBP
prompt Наименование операции: IBP-Internet-Banking: Внутрішня ЕСКРОУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IBP', 'IBP-Internet-Banking: Внутрішня ЕСКРОУ', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0101000000000100000000000000000000010000000000000000000000000000', 'Перерахування коштів відповідно до реєстру  біржових угод');
  exception
    when dup_val_on_index then
      update tts set
        tt='IBP', name='IBP-Internet-Banking: Внутрішня ЕСКРОУ', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101000000000100000000000000000000010000000000000000000000000000', nazn='Перерахування коштів відповідно до реєстру  біржових угод'
       where tt='IBP';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='IBP';
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
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('EXREF', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''EXREF'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBTIM', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBTIM'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV01', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV01'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV02', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV02'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV03', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV03'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV04', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV04'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV05', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV05'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV06', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV06'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV07', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV07'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV08', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV08'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IBV09', 'IBP', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''IBV09'', ''IBP'', ''O'', 0, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='IBP';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('IBC', 'IBP', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''IBC'', ''IBP'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('IBK', 'IBP', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''IBK'', ''IBP'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='IBP';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2600', 'IBP', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''IBP'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2602', 'IBP', 0, '09');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2602'', ''IBP'', 0, ''09'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='IBP';
  begin
    insert into vob(VOB, NAME, FLV, REP_PREFIX)
    values (6, 'Меморiальний ордер', 1, 'MEMORD');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (6, 'IBP');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''IBP'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='IBP';
  begin
    insert into chklist(idchk, name, comm)
    values (25, '25 Операціоніста Клієнт-Банк', null);
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (25, 'IBP', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 25, ''IBP'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='IBP';
  begin
    insert into folders(IDFO, NAME)
    values (25, 'Клієнт-банк (АВТО)');
  exception
    when dup_val_on_index then null;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (25, 'IBP');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 25, ''IBP'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
