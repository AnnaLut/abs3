set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции GO4
prompt Наименование операции: БО: Комисионные доходы по операциям на М/Б ринке
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GO4', 'БО: Комисионные доходы по операциям на М/Б ринке', 1, null, null, '62048', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GO4', name='БО: Комисионные доходы по операциям на М/Б ринке', dk=1, nlsm=null, kv=null, nlsk='62048', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GO4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='GO4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='GO4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='GO4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='GO4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='GO4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='GO4';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GO4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 20, ''GO4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
