set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K73
prompt Наименование операции: K73 Нарах. 3570 комiсiї за ЧЕК ПЕК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K73', 'K73 Нарах. 3570 комiсiї за ЧЕК ПЕК', 1, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', 980, '#(nbs_ob22 (''6510'',''A4''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CEK( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K73', name='K73 Нарах. 3570 комiсiї за ЧЕК ПЕК', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6510'',''A4''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CEK( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K73';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K73';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K73';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K73';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K73';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K73';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K73';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K73');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K73'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
