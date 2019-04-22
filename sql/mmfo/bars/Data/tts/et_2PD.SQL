set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!D
prompt Наименование операции: STOP правило на поповн деп за період
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!D', 'STOP правило на поповн деп за період', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(''1478'',#(KVA),#(NLSB),#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!D', name='STOP правило на поповн деп за період', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(''1478'',#(KVA),#(NLSB),#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!D';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='!!D';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!D';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!D';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='!!D';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!D';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='!!D';
  
  
end;
/

prompt Создание / Обновление операции 2PD
prompt Наименование операции: Списание с 2620 (текущего) на не карточный счет своего РУ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('2PD', 'Списание с 2620 (текущего) на не карточный счет своего РУ', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000010000000010000000000000000000000000000', 'Повернення коштів згідно договору № #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then
      update tts set
        tt='2PD', name='Списание с 2620 (текущего) на не карточный счет своего РУ', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000010000000010000000000000000000000000000', nazn='Повернення коштів згідно договору № #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='2PD';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='2PD';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TTOF1', '2PD', 'O', 0, null, 'KBL', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TTOF1'', ''2PD'', ''O'', 0, null, ''KBL'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', '2PD', 'O', 0, 1, '23', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''2PD'', ''O'', 0, 1, ''23'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='2PD';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!D', '2PD', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!!D'', ''2PD'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='2PD';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='2PD';
  begin
    insert into tts_vob(vob, tt)
    values (6, '2PD');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''2PD'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (102, '2PD');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 102, ''2PD'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='2PD';  
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (98, '2PD', 1, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 98, ''2PD'', 1, null, null, 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='2PD';
  begin
    insert into folders_tts(idfo, tt)
    values (1, '2PD');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''2PD'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
