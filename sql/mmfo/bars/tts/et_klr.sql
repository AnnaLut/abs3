set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KLR
prompt Наименование операции: KLR - Клірінг СЕП, ВПС
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KLR', 'KLR - Клірінг СЕП, ВПС', 1, null, null, null, null, null, null, null, '300465', 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KLR', name='KLR - Клірінг СЕП, ВПС', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='KLR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KLR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KLR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KLR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KLR';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KLR', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''KLR'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KLR';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KLR';
end;
/
commit;
