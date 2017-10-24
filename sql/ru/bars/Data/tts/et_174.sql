set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 174
prompt Наименование операции: 174 Прийом застави по інкас. іменних чеках GBP
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('174', '174 Прийом застави по інкас. іменних чеках GBP', 0, '#(nbs_ob22 (''2622'',''01''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (57, #(KVA), #(NLSA), #(S) ), BANKDATE)', null, 32, null, null, null, '0000100000000000000000000000000000010000000000100000000000000000', 'Прийом застави по інкасованих іменних чеках');
  exception
    when dup_val_on_index then 
      update tts
         set tt='174', name='174 Прийом застави по інкас. іменних чеках GBP', dk=0, nlsm='#(nbs_ob22 (''2622'',''01''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (57, #(KVA), #(NLSA), #(S) ), BANKDATE)', s2=null, sk=32, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000100000000000000000', nazn='Прийом застави по інкасованих іменних чеках'
       where tt='174';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='174';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='174';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='174';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='174';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='174';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '174', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''174'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '174', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''174'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='174';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '174');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''174'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
