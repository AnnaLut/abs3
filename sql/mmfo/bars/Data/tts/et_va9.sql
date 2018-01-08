set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VA9
prompt Наименование операции: VA9 4) Списання виданих лотерейних білетів (позабал.)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VA9', 'VA9 4) Списання виданих лотерейних білетів (позабал.)', 1, '#(VA(''98'') )', null, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', null, null, null, null, null, 0, 0, 0, 0, 'VAK(''9819'')', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VA9', name='VA9 4) Списання виданих лотерейних білетів (позабал.)', dk=1, nlsm='#(VA(''98'') )', kv=null, nlsk='#(branch_usr.get_branch_param2(''NLS_9910'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='VAK(''9819'')', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='VA9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VA9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VA9';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VA9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VA9';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VA9';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VA9';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VA9');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VA9'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
