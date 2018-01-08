set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции OWE
prompt Наименование операции: OWE Дочірня до OWR  реверсал
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWE', 'OWE Дочірня до OWR  реверсал', 1, ' #(GetGlobalOption(''NLS_292427_LOCPAY''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWE', name='OWE Дочірня до OWR  реверсал', dk=1, nlsm=' #(GetGlobalOption(''NLS_292427_LOCPAY''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='OWE';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OWE';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OWE';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OWE';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OWE';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OWE';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OWE';
end;
/
prompt Создание / Обновление операции OWR
prompt Наименование операции: OWR Платіж на вільні реквізити(реверсал)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWR', 'OWR Платіж на вільні реквізити(реверсал)', 1, null, null, ' #(GetGlobalOption(''NLS_292427_LOCPAY''))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWR', name='OWR Платіж на вільні реквізити(реверсал)', dk=1, nlsm=null, kv=null, nlsk=' #(GetGlobalOption(''NLS_292427_LOCPAY''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='OWR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OWR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OWR';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('OWE', 'OWR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''OWE'', ''OWR'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OWR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OWR';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OWR', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''OWR'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OWR';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OWR';
end;
/
commit;
