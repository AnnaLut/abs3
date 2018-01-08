set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MU1
prompt Наименование операции: MU1 --Комісія в грн 100%
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU1', 'MU1 --Комісія в грн 100%', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(F_TARIF_MGE(#(S)),0)', null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU1', name='MU1 --Комісія в грн 100%', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(F_TARIF_MGE(#(S)),0)', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU1';
  begin
    insert into folders_tts(idfo, tt)
    values (11, 'MU1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 11, ''MU1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
