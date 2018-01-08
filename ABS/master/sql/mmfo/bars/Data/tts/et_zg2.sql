set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции ZG2
prompt Наименование операции: ZG2 - Закриття року - автопроводка (внутр.ГРН)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ZG2', 'ZG2 - Закриття року - автопроводка (внутр.ГРН)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, '0', null, '0100000000000000000000000000000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ZG2', name='ZG2 - Закриття року - автопроводка (внутр.ГРН)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0100000000000000000000000000000000010100000000000000000000000000', nazn=null
       where tt='ZG2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='ZG2';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CP_IN', 'ZG2', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CP_IN'', ''ZG2'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('CP_MR', 'ZG2', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''CP_MR'', ''ZG2'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='ZG2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='ZG2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='ZG2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'ZG2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''ZG2'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='ZG2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='ZG2';
end;
/
commit;
