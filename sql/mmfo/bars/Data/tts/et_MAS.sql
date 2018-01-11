set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MA1
prompt Наименование операции: Дочірня до MAS
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MA1', 'Дочірня до MAS', 1, '#(nbs_ob22 (''2920'',''00''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MA1', name='Дочірня до MAS', dk=1, nlsm='#(nbs_ob22 (''2920'',''00''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MA1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MA1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MA1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MA1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MA1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MA1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MA1';
end;
/
prompt Создание / Обновление операции MAS
prompt Наименование операции: MAS Рзрахунки по терміналам TOMAS
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MAS', 'MAS Рзрахунки по терміналам TOMAS', 1, null, null, '#(nbs_ob22 (''2920'',''00''))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MAS', name='MAS Рзрахунки по терміналам TOMAS', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''2920'',''00''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='MAS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MAS';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MAS';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MA1', 'MAS', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MA1'', ''MAS'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MAS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MAS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'MAS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''MAS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MAS';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MAS';
end;
/
commit;
