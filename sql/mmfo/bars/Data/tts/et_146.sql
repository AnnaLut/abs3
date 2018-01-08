set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VPF
prompt Наименование операции: VPF d: Викуп нерозмiнної частини (S) валюти по курсу купiвлi
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VPF', 'VPF d: Викуп нерозмiнної частини (S) валюти по курсу купiвлi', 1, null, null, null, 980, null, '#(tobopack.GetToboCASH)', '#(tobopack.GetToboCASH)', null, 0, 0, 1, 0, 'case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end', 'eqv_obs(#(KVA),case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end ,SYSDATE,1)', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000110000000000000010000000000000000100000000000000000000000000', 'Викуп нерозмiнної частини валюти по курсу купiвлi');
  exception
    when dup_val_on_index then 
      update tts
         set tt='VPF', name='VPF d: Викуп нерозмiнної частини (S) валюти по курсу купiвлi', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa='#(tobopack.GetToboCASH)', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=1, flr=0, s='case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end', s2='eqv_obs(#(KVA),case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end ,SYSDATE,1)', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000110000000000000010000000000000000100000000000000000000000000', nazn='Викуп нерозмiнної частини валюти по курсу купiвлi'
       where tt='VPF';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VPF';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VPF';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VPF';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VPF';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VPF';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VPF';
end;
/
prompt Создание / Обновление операции 146
prompt Наименование операции: 146-Виплата GBP коштів за інкасованими іменними чеками
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('146', '146-Виплата GBP коштів за інкасованими іменними чеками', 1, '#(nbs_ob22 (''2909'',''36''))', 826, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 826, null, '#(nbs_ob22 (''2909'',''36''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '1100100000000000000000000000000000010000000000000000000000000000', 'Виплата GBP коштів за інкасованими іменними чеками');
  exception
    when dup_val_on_index then 
      update tts
         set tt='146', name='146-Виплата GBP коштів за інкасованими іменними чеками', dk=1, nlsm='#(nbs_ob22 (''2909'',''36''))', kv=826, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=826, nlss=null, nlsa='#(nbs_ob22 (''2909'',''36''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100100000000000000000000000000000010000000000000000000000000000', nazn='Виплата GBP коштів за інкасованими іменними чеками'
       where tt='146';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='146';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '146', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ADRES'', ''146'', ''O'', 1, 6, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '146', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ATRT '', ''146'', ''O'', 1, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '146', 'M', 1, 11, '344', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#73 '', ''146'', ''M'', 1, 11, ''344'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '146', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DT_R '', ''146'', ''O'', 1, 5, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '146', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''146'', ''M'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KODPL', '146', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KODPL'', ''146'', ''O'', 1, 7, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '146', 'M', 0, 8, '6', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_B'', ''146'', ''M'', 0, 8, ''6'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '146', 'M', 0, 9, '804', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_G'', ''146'', ''M'', 0, 9, ''804'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '146', 'M', 0, 10, '8446008', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KOD_N'', ''146'', ''M'', 0, 10, ''8446008'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '146', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASP '', ''146'', ''O'', 1, 2, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '146', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''PASPN'', ''146'', ''O'', 1, 3, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('REZID', '146', 'M', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''REZID'', ''146'', ''M'', 1, 5, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='146';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VPF', '146', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''VPF'', ''146'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='146';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='146';
  begin
    insert into tts_vob(vob, tt, ord)
    values (25, '146', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 25, ''146'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='146';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '146', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''146'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '146', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''146'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='146';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '146');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''146'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
