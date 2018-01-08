set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K17
prompt Наименование операции: K17 d: розрахунки за виплачені перекази по системі "Швидка копійка"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K17', 'K17 d: розрахунки за виплачені перекази по системі "Швидка копійка"', 1, null, 980, '373910300465', 980, null, null, null, null, 0, 0, 0, 0, null, null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'розрахунки за виплачені перекази по системі "Швидка копійка"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K17', name='K17 d: розрахунки за виплачені перекази по системі "Швидка копійка"', dk=1, nlsm=null, kv=980, nlsk='373910300465', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='розрахунки за виплачені перекази по системі "Швидка копійка"'
       where tt='K17';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K17';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K17';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K17';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K17';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K17';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K17';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K17');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K17'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
