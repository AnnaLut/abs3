set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции AR*
prompt Наименование операции: AR* Авто-Резерв по НЕстандартним
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('AR*', 'AR* Авто-Резерв по НЕстандартним', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22_nls(''3800'',''16'', #(NLSA)))', null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='AR*', name='AR* Авто-Резерв по НЕстандартним', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22_nls(''3800'',''16'', #(NLSA)))', rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='AR*';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='AR*';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='AR*';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='AR*';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='AR*';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'AR*', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''AR*'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='AR*';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'AR*', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''AR*'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='AR*';
end;
/
commit;
