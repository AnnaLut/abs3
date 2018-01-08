set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K59
prompt Наименование операции: K59 d: Комісія за переказ готівки з ФО (доч до 02C)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K59', 'K59 d: Комісія за переказ готівки з ФО (доч до 02C)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''6510'',''22''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(33, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K59', name='K59 d: Комісія за переказ готівки з ФО (доч до 02C)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''6510'',''22''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(33, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K59';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K59';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K59';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K59';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K59';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K59';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K59';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K59');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K59'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
