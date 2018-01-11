set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K26
prompt Наименование операции: K26 Списано комісію за зарахування коштів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K26', 'K26 Списано комісію за зарахування коштів', 0, null, 980, '#(nbs_ob22 (''6510'',''17''))', 980, null, null, '#(nbs_ob22 (''6510'',''17''))', null, 0, 0, 0, 0, 'F_TARIF(70, #(KVA), #(NLSB), #(S) )', null, null, null, null, null, '0000100000000000000010000000000000000100000000000000000000000000', 'Списано комісію за зарахування коштів');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K26', name='K26 Списано комісію за зарахування коштів', dk=0, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''17''))', kvk=980, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6510'',''17''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(70, #(KVA), #(NLSB), #(S) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000100000000000000000000000000', nazn='Списано комісію за зарахування коштів'
       where tt='K26';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K26';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K26';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K26';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'K26', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''K26'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6510', 'K26', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6510'', ''K26'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K26';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K26';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K26';
end;
/
commit;
