set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции @DI
prompt Наименование операции: @DI - Виплати Родовід-Банку в ЦА
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('@DI', '@DI - Виплати Родовід-Банку в ЦА', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0200000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='@DI', name='@DI - Виплати Родовід-Банку в ЦА', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0200000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='@DI';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='@DI';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='@DI';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='@DI';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='@DI';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '@DI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''@DI'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='@DI';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='@DI';
end;
/
commit;
