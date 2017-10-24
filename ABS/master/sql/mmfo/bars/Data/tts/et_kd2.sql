set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KD2
prompt Наименование операции: КD2 Комісія за створення дод. угод по вкладам ф.о.
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD2', 'КD2 Комісія за створення дод. угод по вкладам ф.о.', 0, null, 980, null, 980, null, '#(nbs_ob22 (''6110'',''28''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 0, 0, 0, 0, 'GET_DPTAGR_TARIF(TO_NUMBER(#(ND)),21)', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'Плата за оформлення дод.угоди  до депозитного договору №#{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD2', name='КD2 Комісія за створення дод. угод по вкладам ф.о.', dk=0, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(nbs_ob22 (''6110'',''28''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='GET_DPTAGR_TARIF(TO_NUMBER(#(ND)),21)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='Плата за оформлення дод.угоди  до депозитного договору №#{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='KD2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KD2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KD2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KD2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KD2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'KD2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 23, ''KD2'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KD2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'KD2', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''KD2'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'KD2', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''KD2'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KD2';
end;
/
commit;
