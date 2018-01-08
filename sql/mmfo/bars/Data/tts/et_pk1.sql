set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PK1
prompt Наименование операции: p) П-Дебет картрахунку
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PK1', 'p) П-Дебет картрахунку', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000110000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PK1', name='p) П-Дебет картрахунку', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000110000000000010000000000000', nazn=null
       where tt='PK1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PK1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PK1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PK1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PK1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PK1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PK1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PK1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PK1';
end;
/
commit;
