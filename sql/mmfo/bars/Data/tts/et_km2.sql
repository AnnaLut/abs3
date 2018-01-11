set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KM2
prompt Наименование операции: KM2 d: комісія за обмін електронних грошей на готівкові кошти по сист 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KM2', 'KM2 d: комісія за обмін електронних грошей на готівкові кошти по сист ', 1, '#(get_nls_tt(''KM2'',''NLSM''))', 980, '#(nbs_ob22 (''6510'',''B8''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(129, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'комісія за обмін електронних грошей на готівкові кошти по сист "ГлобалМані"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KM2', name='KM2 d: комісія за обмін електронних грошей на готівкові кошти по сист ', dk=1, nlsm='#(get_nls_tt(''KM2'',''NLSM''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B8''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(129, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='комісія за обмін електронних грошей на готівкові кошти по сист "ГлобалМані"'
       where tt='KM2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KM2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KM2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KM2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KM2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KM2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KM2';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KM2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''KM2'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
