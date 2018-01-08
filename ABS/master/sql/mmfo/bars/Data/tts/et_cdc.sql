set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CDC
prompt Наименование операции: CDC (доч.CD1) Комісія банку за прийом переказу для Вестерн Юніон
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDC', 'CDC (доч.CD1) Комісія банку за прийом переказу для Вестерн Юніон', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''6510'',''75''))', 980, null, null, null, null, 0, 0, 0, 0, ' F_TARIF_OP(5, 47, #(KVA), #(S), #(NLSA),''CD1'', 0.786)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDC', name='CDC (доч.CD1) Комісія банку за прийом переказу для Вестерн Юніон', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''75''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=' F_TARIF_OP(5, 47, #(KVA), #(S), #(NLSA),''CD1'', 0.786)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDC';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CDC';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CDC';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CDC';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CDC';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CDC';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CDC', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CDC'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CDC', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CDC'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CDC';
end;
/
commit;
