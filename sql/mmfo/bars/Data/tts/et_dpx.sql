set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DPX
prompt Наименование операции: Перерахування вкладу на поточний рах.по закінч.строку
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DPX', 'Перерахування вкладу на поточний рах.по закінч.строку', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000000000000000000000000000000000000000000', 'Повернення коштів згідно договору #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DPX', name='Перерахування вкладу на поточний рах.по закінч.строку', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Повернення коштів згідно договору #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DPX';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DPX';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DPX';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DPX';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DPX';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DPX', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''DPX'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (46, 'DPX', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 46, ''DPX'', 2) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DPX';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DPX', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''DPX'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DPX', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DPX'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DPX';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DPX');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''DPX'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
