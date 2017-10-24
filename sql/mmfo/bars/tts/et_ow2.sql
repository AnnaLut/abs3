set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции OW2
prompt Наименование операции: OpenWay: Мультивалютная
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OW2', 'OpenWay: Мультивалютная', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '38005003010', null, '0100100000000000000000000000000000000110000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OW2', name='OpenWay: Мультивалютная', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='38005003010', rang=null, flags='0100100000000000000000000000000000000110000000000000000000000000', nazn=null
       where tt='OW2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OW2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OW2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OW2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OW2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'OW2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''OW2'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OW2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OW2';
end;
/
commit;
