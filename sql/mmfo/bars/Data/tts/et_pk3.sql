set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PK3
prompt Наименование операции: p) П-Дебет картрахунку (мультивалютна)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PK3', 'p) П-Дебет картрахунку (мультивалютна)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000010110000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PK3', name='p) П-Дебет картрахунку (мультивалютна)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000010110000000000000000000000000', nazn=null
       where tt='PK3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PK3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PK3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PK3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PK3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PK3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''PK3'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PK3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PK3';
end;
/
commit;
