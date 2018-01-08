set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции NLE
prompt Наименование операции: Відшкодув.коштів по ЕнергоКредитам
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('NLE', 'Відшкодув.коштів по ЕнергоКредитам', null, '#(get_proc_nls(''T00'',#(KVA)))', null, '#( vkrzn( substr(f_ourmfo,1,5), ''3739_05'') )', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='NLE', name='Відшкодув.коштів по ЕнергоКредитам', dk=null, nlsm='#(get_proc_nls(''T00'',#(KVA)))', kv=null, nlsk='#( vkrzn( substr(f_ourmfo,1,5), ''3739_05'') )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='NLE';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='NLE';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='NLE';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='NLE';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='NLE';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='NLE';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='NLE';
end;
/
commit;
