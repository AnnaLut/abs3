set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K06
prompt Наименование операции: K06 розрахунки за прийняті перекази по системі  "Золота Корона"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K06', 'K06 розрахунки за прийняті перекази по системі  "Золота Корона"', 1, null, null, '373910300465', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'розрахунки за прийняті перекази по системі  "Юністрім"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K06', name='K06 розрахунки за прийняті перекази по системі  "Золота Корона"', dk=1, nlsm=null, kv=null, nlsk='373910300465', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='розрахунки за прийняті перекази по системі  "Юністрім"'
       where tt='K06';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K06';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K06';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K06';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K06';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'K06', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 23, ''K06'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K06';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K06';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K06');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K06'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
