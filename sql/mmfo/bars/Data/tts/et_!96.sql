set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt —оздание / ќбновление операции !96
prompt Ќаименование операции: STOP-контроль(введення корегуючих)
declare
  cnt_  number;
begin
  --------------------------------
  -- ќсновные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!96', 'STOP-контроль(введення корегуючих)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_stop_zo(#(REF))', null, null, null, null, null, '0000100000000000000000000001000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!96', name='STOP-контроль(введення корегуючих)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_stop_zo(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000100000000000000000000000000', nazn=null
       where tt='!96';
  end;
  --------------------------------
  ----------- –еквизиты ----------
  --------------------------------
  delete from op_rules where tt='!96';
  --------------------------------
  ------ —в€занные операции ------
  --------------------------------
  delete from ttsap where tt='!96';
  --------------------------------
  ------- Ѕалансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!96';
  --------------------------------
  -------- ¬иды документов -------
  --------------------------------
  delete from tts_vob where tt='!96';
  --------------------------------
  -------- √руппы контрол€ -------
  --------------------------------
  delete from chklist_tts where tt='!96';
  --------------------------------
  ------------- ѕапки ------------
  --------------------------------
  delete from folders_tts where tt='!96';
end;
/
commit;
