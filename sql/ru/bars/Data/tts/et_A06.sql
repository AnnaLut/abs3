set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции A06
prompt Наименование операции: A06  ІНКАСО банкнот ФО з комісією (A05,A16)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('A06', 'A06  ІНКАСО банкнот ФО з комісією (A05,A16)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='A06', name='A06  ІНКАСО банкнот ФО з комісією (A05,A16)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='A06';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='A06';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='A06';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='A06';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='A06';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='A06';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='A06';
  begin
    insert into folders_tts(idfo, tt)
    values (15, 'A06');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 15, ''A06'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
