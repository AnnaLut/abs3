set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt —оздание / ќбновление операции RSM
prompt Ќаименование операции: RSM ѕерерахуванн¤ кошт?в на користь  л?Їнт?в (зовн?шн?й)
declare
  cnt_  number;
begin
  --------------------------------
  -- ќсновные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('RSM', 'RSM ѕерерахуванн¤ кошт?в на користь  л?Їнт?в (зовн?шн?й)', 1, null, null, '#(get_proc_nls(''T00'', NVL ( #(KVA), 980 ) ) )', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '0201100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='RSM', name='RSM ѕерерахуванн¤ кошт?в на користь  л?Їнт?в (зовн?шн?й)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'', NVL ( #(KVA), 980 ) ) )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0201100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='RSM';
  end;
  --------------------------------
  ----------- –еквизиты ----------
  --------------------------------
  delete from op_rules where tt='RSM';
  --------------------------------
  ------ —в¤занные операции ------
  --------------------------------
  delete from ttsap where tt='RSM';
  --------------------------------
  ------- Ѕалансовые счета -------
  --------------------------------
  delete from ps_tts where tt='RSM';
  --------------------------------
  -------- ¬иды документов -------
  --------------------------------
  delete from tts_vob where tt='RSM';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'RSM', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Ќе удалось добавить запись (tts_vob: 6, ''RSM'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- vруппы контрол¤ -------
  --------------------------------
  delete from chklist_tts where tt='RSM';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'RSM', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''RSM'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ѕапки ------------
  --------------------------------
  delete from folders_tts where tt='RSM';
end;
/
commit;
