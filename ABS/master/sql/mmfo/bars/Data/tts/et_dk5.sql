set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DK5
prompt Наименование операции: DK5 +Виплата відсотків в нац.валюті (внутр)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DK5', 'DK5 +Виплата відсотків в нац.валюті (внутр)', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000010000000010100000000000000000000000000', 'Виплата відсотків згідно договору № #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DK5', name='DK5 +Виплата відсотків в нац.валюті (внутр)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000010000000010100000000000000000000000000', nazn='Виплата відсотків згідно договору № #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DK5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DK5';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DK5', 'O', 0, 1, '43', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''DK5'', ''O'', 0, 1, ''43'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TTOF1', 'DK5', 'O', 0, null, 'KBG', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''TTOF1'', ''DK5'', ''O'', 0, null, ''KBG'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DK5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DK5';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DK5';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DK5', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''DK5'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (102, 'DK5', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 102, ''DK5'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DK5';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DK5';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DK5');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 1, ''DK5'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
