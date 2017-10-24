set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции OW9
prompt Наименование операции: OW9 Платіж на вільні реквізити з поточного рахунка(комісія)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OW9', 'OW9 Платіж на вільні реквізити з поточного рахунка(комісія)', 1, null, null, '#(GetGlobalOption(''NLS_373914_LOCPAYFEE''))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OW9', name='OW9 Платіж на вільні реквізити з поточного рахунка(комісія)', dk=1, nlsm=null, kv=null, nlsk='#(GetGlobalOption(''NLS_373914_LOCPAYFEE''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='OW9';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='OW9';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='OW9';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='OW9';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='OW9';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OW9', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''OW9'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='OW9';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='OW9';
end;
/
commit;
