set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K63
prompt Наименование операции: K63 Комісія за виплату переказів готівкою, що надійшов з іншого банку
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K63', 'K63 Комісія за виплату переказів готівкою, що надійшов з іншого банку', 1, '#(nbs_ob22 (''6510'',''22''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(63, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', 'Комісія за виплату переказів готівкою, що надійшов з іншого банку');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K63', name='K63 Комісія за виплату переказів готівкою, що надійшов з іншого банку', dk=1, nlsm='#(nbs_ob22 (''6510'',''22''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(63, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Комісія за виплату переказів готівкою, що надійшов з іншого банку'
       where tt='K63';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K63';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K63';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K63';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K63';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K63';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K63';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K63');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K63'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
