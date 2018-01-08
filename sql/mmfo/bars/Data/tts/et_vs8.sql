set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VS8
prompt Наименование операции: VS8 ---Передача цінності: ОПЧ -> сховище
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VS8', 'VS8 ---Передача цінності: ОПЧ -> сховище', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010000000000000000000000000001', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VS8', name='VS8 ---Передача цінності: ОПЧ -> сховище', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000000000000000000001', nazn=null
       where tt='VS8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VS8';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'VS8', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''VS8'', ''M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('VA_KC', 'VS8', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''VA_KC'', ''VS8'', ''M'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VS8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VS8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VS8';
  begin
    insert into tts_vob(vob, tt, ord)
    values (222, 'VS8', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 222, ''VS8'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VS8';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VS8';
  begin
    insert into folders_tts(idfo, tt)
    values (93, 'VS8');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 93, ''VS8'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
