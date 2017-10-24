set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SIF
prompt Наименование операции: Уведомление о выполнении перевода
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SIF', 'Уведомление о выполнении перевода', 3, null, null, null, null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300000000000000000000000001000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SIF', name='Уведомление о выполнении перевода', dk=3, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300000000000000000000000001000000000100000000000000000000000000', nazn=null
       where tt='SIF';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SIF';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SIF';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SIF';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SIF';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SIF', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SIF'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SIF';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SIF';
  begin
    insert into folders_tts(idfo, tt)
    values (72, 'SIF');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 72, ''SIF'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
