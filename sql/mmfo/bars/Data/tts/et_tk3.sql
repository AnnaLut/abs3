set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции TK3
prompt Наименование операции: TK3 Розподіл сум для компенсаційних вкладів по Укрпошті
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TK3', 'TK3 Розподіл сум для компенсаційних вкладів по Укрпошті', 1, null, null, null, null, null, null, '2906301301', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TK3', name='TK3 Розподіл сум для компенсаційних вкладів по Укрпошті', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='2906301301', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='TK3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='TK3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='TK3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='TK3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='TK3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'TK3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''TK3'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='TK3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='TK3';
end;
/
commit;
