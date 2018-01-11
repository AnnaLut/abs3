set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt —оздание / ќбновление операции !15
prompt Ќаименование операции: !15 STOP-контроль(сума виплати >150 000 з початку м≥с€ц€)
declare
  cnt_  number;
begin
  --------------------------------
  -- ќсновные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!15', '!15 STOP-контроль(сума виплати >150 000 з початку м≥с€ц€)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_PAYMENT(#(REF))', null, null, null, null, null, '0000100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!15', name='!15 STOP-контроль(сума виплати >150 000 з початку м≥с€ц€)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='!15';
  end;
  --------------------------------
  ----------- –еквизиты ----------
  --------------------------------
  delete from op_rules where tt='!15';
  --------------------------------
  ------ —в€занные операции ------
  --------------------------------
  delete from ttsap where tt='!15';
  --------------------------------
  ------- Ѕалансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!15';
  --------------------------------
  -------- ¬иды документов -------
  --------------------------------
  delete from tts_vob where tt='!15';
  --------------------------------
  -------- √руппы контрол€ -------
  --------------------------------
  delete from chklist_tts where tt='!15';
  --------------------------------
  ------------- ѕапки ------------
  --------------------------------
  delete from folders_tts where tt='!15';
end;
/
commit;
