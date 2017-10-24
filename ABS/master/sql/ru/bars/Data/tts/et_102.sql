set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 102
prompt Наименование операции: 102 Комісія за обробку іменних чеків в USD
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('102', '102 Комісія за обробку іменних чеків в USD', 0, '#(nbs_ob22 (''3739'',''06''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (59, #(KVA), #(NLSA), #(S) ), BANKDATE)', null, 5, null, null, null, '0000100000000000000000000000000000010000000000100000000000000000', 'Комісія ін.банку за обробку іменних чеків USD');
  exception
    when dup_val_on_index then 
      update tts
         set tt='102', name='102 Комісія за обробку іменних чеків в USD', dk=0, nlsm='#(nbs_ob22 (''3739'',''06''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (59, #(KVA), #(NLSA), #(S) ), BANKDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000100000000000000000', nazn='Комісія ін.банку за обробку іменних чеків USD'
       where tt='102';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='102';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='102';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='102';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='102';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='102';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='102';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '102');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''102'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
