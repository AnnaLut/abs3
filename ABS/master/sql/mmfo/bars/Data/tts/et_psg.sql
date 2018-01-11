set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PSG
prompt Наименование операции: PSG p) Перекриття-згортання(внутрішня) БЕЗ ВІЗ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PSG', 'PSG p) Перекриття-згортання(внутрішня) БЕЗ ВІЗ', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PSG', name='PSG p) Перекриття-згортання(внутрішня) БЕЗ ВІЗ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000100000000000010000000000000', nazn=null
       where tt='PSG';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PSG';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PSG';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PSG';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PSG';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PSG', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PSG'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PSG';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PSG';
end;
/
commit;
