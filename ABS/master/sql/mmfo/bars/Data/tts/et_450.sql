set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 450
prompt Наименование операции: На суму комісії
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('450', 'На суму комісії', 1, '#(#(NLSB))', 980, '#( nbs_ob22 (''6119'',''25'') )', 980, null, null, null, null, 0, 0, 0, 0, '#(S)*5/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='450', name='На суму комісії', dk=1, nlsm='#(#(NLSB))', kv=980, nlsk='#( nbs_ob22 (''6119'',''25'') )', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)*5/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='450';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='450';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='450';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='450';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='450';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='450';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='450';
end;
/
commit;
