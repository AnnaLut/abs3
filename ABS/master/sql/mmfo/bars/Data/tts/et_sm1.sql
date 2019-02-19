set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt —оздание / ќбновление операции SM1
prompt Ќаименование операции: SM1 ѕерерахуванн¤ кошт?в на користь  л?Їнт?в ќсновний плат?ж (внутр?шний)
declare
  cnt_  number;
begin
  --------------------------------
  -- ќсновные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SM1', 'SM1 ѕерерахуванн¤ кошт?в на користь  л?Їнт?в (внутр?шний)', 1, null, null, null, null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SM1', name='SM1 ѕерерахуванн¤ кошт?в на користь  л?Їнт?в (внутр?шний)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='SM1';
  end;
  --------------------------------
  ----------- –еквизиты ----------
  --------------------------------
  delete from op_rules where tt='SM1';
  --------------------------------
  ------ —в¤занные операции ------
  --------------------------------
  delete from ttsap where tt='SM1';
  --------------------------------
  ------- Ѕалансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SM1';
  --------------------------------
  -------- ¬иды документов -------
  --------------------------------
  delete from tts_vob where tt='SM1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SM1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Ќе удалось добавить запись (tts_vob: 6, ''SM1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- vруппы контрол¤ -------
  --------------------------------
  delete from chklist_tts where tt='SM1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'SM1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''SM1'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ѕапки ------------
  --------------------------------
  delete from folders_tts where tt='SM1';
end;
/
commit;
