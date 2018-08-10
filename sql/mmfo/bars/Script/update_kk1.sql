prompt Создание / Обновление операции KKW
prompt Наименование операции: KKW - видача кредиту на ПК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KKW', 'KKW - видача кредиту на ПК', null, '#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))', null, '#(cck_dop.get_kkw_crd(#(REF)))', null, null, null, null, null, 0, 0, 0, 0, 'cck_dop.get_amount_kkw(#(REF))', null, null, null, '0', null, '0001100000000000000000000001000000010000000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KKW', name='KKW - видача кредиту на ПК', dk=null, nlsm='#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))', kv=null, nlsk='#(cck_dop.get_kkw_crd(#(REF)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='cck_dop.get_amount_kkw(#(REF))', s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0001100000000000000000000001000000010000000000100000000000000000', nazn=null
       where tt='KKW';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KKW';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KKW';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KKW';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KKW';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KKW';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KKW';
end;
/

      update tts
         set nlsk='#(cck_dop.get_kk1_crd(#(NLSB),#(KVA),#(NLSA)))'
       where tt='KK1';


  begin
    insert into ttsap(ttap, tt, dk)
    values ('KKW', 'KK1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''KKW'', ''KK1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
/

  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'KK1', 9, null, 'bpk_visa30(ref, 1)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''KK1'', 9, null, ''bpk_visa30(ref, 1)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
/