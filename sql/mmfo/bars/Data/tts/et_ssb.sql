set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SSB
prompt Наименование операции: SSB - Виплати на поховання
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SSB', 'SSB - Виплати на поховання', 1, null, null, '#(bpk_get_transit(''1X'',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0000000000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='SSB', name='SSB - Виплати на поховання', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''1X'',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='SSB';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='SSB';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SK_ZB', 'SSB', 'O', 0, null, '87', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''SK_ZB'', ''SSB'', ''O'', 0, null, ''87'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SSB';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SSB';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='SSB';
  begin
    insert into tts_vob(vob, tt)
    values (6, 'SSB');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SSB'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SSB';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (23, 'SSB', 1, null, 'mfob<>''300465''', 3);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 23, ''SSB'', 1, null, ''mfob<>''''300465'''''', 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'SSB', 2, null, 'mfob=''300465''', 1);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''SSB'', 2, null, ''mfob=''''300465'''''', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='SSB';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'SSB');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''SSB'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/

begin
  --------------------------------------------------------
  -----Опис транзакцій ПЦ для квитовки операцій Банку-----
  begin
    insert into obpc_trans_out(tran_type, tt, dk, w4_msgcode, pay_flag)
    values ('1X', 'SSB', 1, 'PAYACC',0);
  exception
    when dup_val_on_index then null;
  end;
  
end;
/

commit;
