set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции D98
prompt Наименование операции: D98 - %% на залишки по коррах 100%(10% -D91)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D98', 'D98 - %% на залишки по коррах 100%(10% -D91)', 0, null, null, '74192031501501', 980, null, null, null, '300465', 0, 0, 1, 0, '0.1  * #(S)', '0.1  *  gl.p_icurval( #(KVA), #(S), bankdate )', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='D98', name='D98 - %% на залишки по коррах 100%(10% -D91)', dk=0, nlsm=null, kv=null, nlsk='74192031501501', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=0, fli=0, flv=1, flr=0, s='0.1  * #(S)', s2='0.1  *  gl.p_icurval( #(KVA), #(S), bankdate )', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='D98';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D98';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D98';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D98';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D98';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D98';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D98';
end;
/
commit;
