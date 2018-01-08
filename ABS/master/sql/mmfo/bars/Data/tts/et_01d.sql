set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции КЧМ
prompt Наименование операции: КЧМ Комісія за ЧЕК (монети)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('КЧМ', 'КЧМ Комісія за ЧЕК (монети)', 1, null, 980, '#(nbs_ob22 (''6110'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'f_monet_tar(111,F_DOP(#(REF), (''M_1'')),F_DOP(#(REF), (''M_2'')),F_DOP(#(REF), (''M_5'')),F_DOP(#(REF), (''M_10'')),F_DOP(#(REF), (''M_25'')),F_DOP(#(REF), (''M_50'')))', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', ' Комісія за виплату монет по чеку ЮО');
  exception
    when dup_val_on_index then 
      update tts
         set tt='КЧМ', name='КЧМ Комісія за ЧЕК (монети)', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6110'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_monet_tar(111,F_DOP(#(REF), (''M_1'')),F_DOP(#(REF), (''M_2'')),F_DOP(#(REF), (''M_5'')),F_DOP(#(REF), (''M_10'')),F_DOP(#(REF), (''M_25'')),F_DOP(#(REF), (''M_50'')))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=' Комісія за виплату монет по чеку ЮО'
       where tt='КЧМ';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='КЧМ';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='КЧМ';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='КЧМ';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='КЧМ';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'КЧМ', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 23, ''КЧМ'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='КЧМ';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='КЧМ';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'КЧМ');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''КЧМ'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции 01D
prompt Наименование операции: 01D-Видача по ЧЕКУ монети (з коміс. )
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('01D', '01D-Видача по ЧЕКУ монети (з коміс. )', 1, null, 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, '#(M_1)*0.01+#(M_2)*0.02+#(M_5)*0.05+#(M_10)*0.1+#(M_25)*0.25+#(M_50)*0.5', null, null, null, null, null, '1000100001000001100000000000000000010000000000000000000000000000', 'Видаток готівки по чеку');
  exception
    when dup_val_on_index then 
      update tts
         set tt='01D', name='01D-Видача по ЧЕКУ монети (з коміс. )', dk=1, nlsm=null, kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s='#(M_1)*0.01+#(M_2)*0.02+#(M_5)*0.05+#(M_10)*0.1+#(M_25)*0.25+#(M_50)*0.5', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100001000001100000000000000000010000000000000000000000000000', nazn='Видаток готівки по чеку'
       where tt='01D';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='01D';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('M_1  ', '01D', 'M', 1, 1, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''M_1  '', ''01D'', ''M'', 1, 1, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('M_10 ', '01D', 'M', 1, 4, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''M_10 '', ''01D'', ''M'', 1, 4, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('M_2  ', '01D', 'M', 1, 2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''M_2  '', ''01D'', ''M'', 1, 2, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('M_25 ', '01D', 'M', 1, 5, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''M_25 '', ''01D'', ''M'', 1, 5, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('M_5  ', '01D', 'M', 1, 3, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''M_5  '', ''01D'', ''M'', 1, 3, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('M_50 ', '01D', 'M', 1, 6, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''M_50 '', ''01D'', ''M'', 1, 6, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='01D';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('КЧМ', '01D', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''КЧМ'', ''01D'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='01D';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', '01D', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''01D'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', '01D', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1002'', ''01D'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2560', '01D', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2560'', ''01D'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', '01D', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''01D'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2650', '01D', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2650'', ''01D'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='01D';
  begin
    insert into tts_vob(vob, tt, ord)
    values (44, '01D', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 44, ''01D'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='01D';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '01D', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''01D'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '01D', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''01D'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='01D';
  begin
    insert into folders_tts(idfo, tt)
    values (91, '01D');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 91, ''01D'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
