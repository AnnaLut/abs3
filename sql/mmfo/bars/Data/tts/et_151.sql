set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 151
prompt Наименование операции: d: Видано суму інкасованої ІВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('151', 'd: Видано суму інкасованої ІВ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='151', name='d: Видано суму інкасованої ІВ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='151';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='151';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('73151', '151', 'M', 0, null, '370', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''73151'', ''151'', ''M'', 0, null, ''370'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='151';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='151';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='151';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='151';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='151';
  begin
    insert into folders_tts(idfo, tt)
    values (15, '151');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 15, ''151'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
