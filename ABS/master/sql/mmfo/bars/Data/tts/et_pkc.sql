set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PKC
prompt Наименование операции: PKC p) П-Удержание % на кредит по карточкам
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PKC', 'PKC p) П-Удержание % на кредит по карточкам', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010110000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PKC', name='PKC p) П-Удержание % на кредит по карточкам', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010110000000000000000000000000', nazn=null
       where tt='PKC';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PKC';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PKC';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PKC';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PKC';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PKC', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PKC'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PKC';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PKC';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'PKC');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''PKC'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
