set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции O99
prompt Наименование операции: O99 П-Учет неиспользованного лимита overdraft`а в 9-м класс
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('O99', 'O99 П-Учет неиспользованного лимита overdraft`а в 9-м класс', 1, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BPK_KR9900'',0))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='O99', name='O99 П-Учет неиспользованного лимита overdraft`а в 9-м класс', dk=1, nlsm=null, kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''BPK_KR9900'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='O99';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='O99';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='O99';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='O99';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='O99';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'O99', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''O99'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='O99';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='O99';
end;
/
commit;
