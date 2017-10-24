set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 421
prompt Наименование операции: 421 Оприбуткування на позабал.рах списаної суми безнадійної заборг
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('421', '421 Оприбуткування на позабал.рах списаної суми безнадійної заборг', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 1, null, null, null, null, null, null, '1100100000000000000000000000000000010000000000000000000000000000', 'Оприбуткування на позабалансовому рахунку списаної суми безнадійної заборгованості за іншими нарахованими доходами');
  exception
    when dup_val_on_index then 
      update tts
         set tt='421', name='421 Оприбуткування на позабал.рах списаної суми безнадійної заборг', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100100000000000000000000000000000010000000000000000000000000000', nazn='Оприбуткування на позабалансовому рахунку списаної суми безнадійної заборгованості за іншими нарахованими доходами'
       where tt='421';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='421';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='421';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='421';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9601', '421', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9601'', ''421'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', '421', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''9910'', ''421'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='421';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, '421', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 206, ''421'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='421';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '421', 2, null, '(visa_asvo(userid)=1 AND nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''421'', 2, null, ''(visa_asvo(userid)=1 AND nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0)'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '421', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''421'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='421';
  begin
    insert into folders_tts(idfo, tt)
    values (44, '421');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 44, ''421'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
