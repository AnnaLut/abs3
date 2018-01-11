set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VB2
prompt Наименование операции: VB2 ---VB2 Перерахування на заг.рахунок
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB2', 'VB2 ---VB2 Перерахування на заг.рахунок', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, '#(S)-#(S)*0.07', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB2', name='VB2 ---VB2 Перерахування на заг.рахунок', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-#(S)*0.07', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='VB2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VB2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VB2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VB2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VB2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VB2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VB2';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 19, ''VB2'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
