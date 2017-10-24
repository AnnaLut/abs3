set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции G01
prompt Наименование операции: G01
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G01', 'G01 ГЕРЦ Касові', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0001100000000000000000000000000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='G01', name='G01 ГЕРЦ Касові ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000000000000000000000000000010100000000000000000000000000', nazn=null
       where tt='G01';
  end;
  
  delete from op_rules where tt = 'G01';
  delete from ps_tts where tt = 'G01';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('100 ', 'G01', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''100 '', ''G01'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('290 ', 'G01', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''290 '', ''G01'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  begin
    insert into tts_vob(vob, tt)
    values (6, 'G01');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''G01'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G01';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'G01', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''G01'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/
begin
 insert into GERC_TTS (tt,name) values ('G01','Касові ГЕРЦ');
exception when dup_val_on_index then null;
end;
/
commit;
/
