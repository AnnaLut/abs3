set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VK1
prompt Наименование операции: VK1 (доч VM5) Ком на сум різн між відп цін НБУ (без ПДВ) та номін варт
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VK1', 'VK1 (доч VM5) Ком на сум різн між відп цін НБУ (без ПДВ) та номін варт', 1, null, 980, '#(nbs_ob22 (''3500'',''07''))', 980, null, null, '#(nbs_ob22 (''3500'',''07''))', null, 0, 0, 0, 0, '(#(BM_NB)*#(BM__K))*100', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VK1', name='VK1 (доч VM5) Ком на сум різн між відп цін НБУ (без ПДВ) та номін варт', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3500'',''07''))', kvk=980, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''3500'',''07''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='(#(BM_NB)*#(BM__K))*100', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='VK1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VK1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VK1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VK1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3500', 'VK1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3500'', ''VK1'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3907', 'VK1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3907'', ''VK1'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VK1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VK1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VK1';
  begin
    insert into folders_tts(idfo, tt)
    values (37, 'VK1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 37, ''VK1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
