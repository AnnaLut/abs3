set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции P2D
prompt Наименование операции: P2D Дочірня до P2V   Internet_Banking внутрібанк 2620-2620
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2D', 'P2D Дочірня до P2V   Internet_Banking внутрібанк 2620-2620', 1, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2D', name='P2D Дочірня до P2V   Internet_Banking внутрібанк 2620-2620', dk=1, nlsm='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='P2D';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='P2D';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='P2D';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='P2D';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='P2D';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='P2D';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='P2D';
end;
/
prompt Создание / Обновление операции P2V
prompt Наименование операции: P2V Internet_Banking внутрібанк 2620-2620
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2V', 'P2V Internet_Banking внутрібанк 2620-2620', 1, null, null, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2V', name='P2V Internet_Banking внутрібанк 2620-2620', dk=1, nlsm=null, kv=null, nlsk='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='P2V';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='P2V';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='P2V';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('P2D', 'P2V', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''P2D'', ''P2V'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='P2V';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='P2V';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'P2V', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''P2V'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='P2V';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='P2V';
end;
/
commit;
