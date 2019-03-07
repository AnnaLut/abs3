set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PXR
prompt Наименование операции: PXR-Оплата монетизації(ВПС)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PXR', 'PXR-Оплата монетизації(ВПС)', 1, null, null, '#(get_proc_nls(''T00'', NVL ( #(KVA), 980 ) ) )', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PXR', name='PXR-Оплата монетизації(ВПС)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'', NVL ( #(KVA), 980 ) ) )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='PXR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PXR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PXR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PXR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PXR';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'PXR', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 1, ''PXR'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PXR';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'PXR', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''PXR'', 1, null, null, 3) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PXR';
end;
/
commit;
