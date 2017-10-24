set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CBB
prompt Наименование операции: (доч.CA2) Комісія агента за прийом переказу для MIGOM
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CBB', '(доч.CA2) Комісія агента за прийом переказу для MIGOM', 1, '#(nbs_ob22 (''2909'',''40''))', 980, '#(nbs_ob22 (''2909'',''40''))', 840, null, null, null, null, 0, 0, 1, 0, 'F_TARIF_OP(4, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', 'F_TARIF_OP(3, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CBB', name='(доч.CA2) Комісія агента за прийом переказу для MIGOM', dk=1, nlsm='#(nbs_ob22 (''2909'',''40''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''40''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='F_TARIF_OP(4, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', s2='F_TARIF_OP(3, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CBB';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CBB';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CBB';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CBB';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CBB', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''26  '', ''CBB'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CBB';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CBB';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CBB';
end;
/
commit;
