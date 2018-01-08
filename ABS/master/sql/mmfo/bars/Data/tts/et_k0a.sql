set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K0A
prompt Наименование операции: K0A Нарах. 3570 комiсiї за ЧЕК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0A', 'K0A Нарах. 3570 комiсiї за ЧЕК', 1, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', 980, '#(nbs_ob22 (''6510'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CEK( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0A', name='K0A Нарах. 3570 комiсiї за ЧЕК', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6510'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CEK( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K0A';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K0A';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K0A';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K0A';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K0A';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K0A';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K0A';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K0A');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K0A'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
