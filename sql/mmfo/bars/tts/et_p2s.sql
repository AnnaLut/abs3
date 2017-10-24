set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!3
prompt Наименование операции: :STOP ! МФОА=МФОБ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!3', ':STOP ! МФОА=МФОБ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(3,#(MFOA),'''',#(MFOB))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!3', name=':STOP ! МФОА=МФОБ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(3,#(MFOA),'''',#(MFOB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!!3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!!3';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!!3';
end;
/
prompt Создание / Обновление операции P2C
prompt Наименование операции: Дочірня до P2S   Internet_Banking міжбанк 2620-2620
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2C', 'Дочірня до P2S   Internet_Banking міжбанк 2620-2620', 1, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2C', name='Дочірня до P2S   Internet_Banking міжбанк 2620-2620', dk=1, nlsm='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='P2C';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='P2C';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='P2C';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='P2C';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='P2C';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='P2C';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='P2C';
end;
/
prompt Создание / Обновление операции P2S
prompt Наименование операции: Web-banking перерахування коштів з потчного рах. на міжбанк
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2S', 'Web-banking перерахування коштів з потчного рах. на міжбанк', 1, null, null, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '0300000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2S', name='Web-banking перерахування коштів з потчного рах. на міжбанк', dk=1, nlsm=null, kv=null, nlsk='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='P2S';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='P2S';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='P2S';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!3', 'P2S', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!!3'', ''P2S'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('P2C', 'P2S', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''P2C'', ''P2S'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='P2S';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='P2S';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'P2S', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''P2S'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'P2S', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''P2S'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='P2S';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (97, 'P2S', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 97, ''P2S'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='P2S';
end;
/
commit;
