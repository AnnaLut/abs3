set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W4Z
prompt Наименование операции: W4Z Міжбанк. платіж на рах. іншої особи(з комісією) в іншому 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W4Z', 'W4Z Міжбанк. платіж на рах. іншої особи(з комісією) в іншому ', 1, '#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '1300000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='W4Z', name='W4Z Міжбанк. платіж на рах. іншої особи(з комісією) в іншому ', dk=1, nlsm='#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1300000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='W4Z';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='W4Z';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W4Z';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W4Z';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='W4Z';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W4Z';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'W4Z', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''W4Z'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'W4Z', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''W4Z'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='W4Z';
end;
/
commit;
