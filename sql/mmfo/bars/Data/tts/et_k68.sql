set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K68
prompt Наименование операции: K68  Комiсiя за ЧЕК Казначейства 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K68', 'K68  Комiсiя за ЧЕК Казначейства ', 1, '#(F_DOP(#(REF),''S3570''))', 980, '#(nbs_ob22 (''6110'',''44''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_DOP(#(REF),''PR068'')*#(S)/100', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K68', name='K68  Комiсiя за ЧЕК Казначейства ', dk=1, nlsm='#(F_DOP(#(REF),''S3570''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''44''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_DOP(#(REF),''PR068'')*#(S)/100', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K68';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K68';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K68';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K68';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K68';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K68';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K68';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K68');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K68'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
