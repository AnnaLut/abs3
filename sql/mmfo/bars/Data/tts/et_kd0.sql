set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KD0
prompt Наименование операции: КD0 Комісія за оформлення довіреності по рахунках ФО
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD0', 'КD0 Комісія за оформлення довіреності по рахунках ФО', 0, null, 980, null, 980, null, '#(nbs_ob22 (''6110'',''28''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 0, 0, 0, 0, 'GET_DPTAGR_TARIF(TO_NUMBER(#(ND)),51)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', ' Комісія за оформлення довіреності  до депозитного договору №#{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD0', name='КD0 Комісія за оформлення довіреності по рахунках ФО', dk=0, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(nbs_ob22 (''6110'',''28''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='GET_DPTAGR_TARIF(TO_NUMBER(#(ND)),51)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=' Комісія за оформлення довіреності  до депозитного договору №#{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='KD0';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KD0';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KD0';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KD0';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KD0';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'KD0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 23, ''KD0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KD0';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'KD0', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''KD0'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'KD0', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''KD0'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KD0';
end;
/
commit;
