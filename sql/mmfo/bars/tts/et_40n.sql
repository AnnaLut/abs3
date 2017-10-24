set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 40N
prompt Наименование операции: 40N  Внесення готівки на рах.акредитованого нотаріуса (з комі
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('40N', '40N  Внесення готівки на рах.акредитованого нотаріуса (з комі', 0, '#(nbs_ob22(''2902'',''06''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, null, null, 16, null, null, null, '1100100001000000000000000011000000010000000000000000000000000000', 'За надані послуги в рамках кредитного договору №_____ від __________ ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='40N', name='40N  Внесення готівки на рах.акредитованого нотаріуса (з комі', dk=0, nlsm='#(nbs_ob22(''2902'',''06''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=16, proc=null, s3800=null, rang=null, flags='1100100001000000000000000011000000010000000000000000000000000000', nazn='За надані послуги в рамках кредитного договору №_____ від __________ '
       where tt='40N';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='40N';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='40N';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='40N';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='40N';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='40N';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '40N', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''1''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 1, ''40N'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''1'''''', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '40N', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''40N'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='40N';
end;
/
commit;
