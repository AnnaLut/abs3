set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !S1
prompt ������������ ��������: !S1 �������� ������� �� CFS/SWT  (MT 103)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!S1', '!S1 �������� ������� �� CFS/SWT  (MT 103)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_stop_op( 1 , #(REF),''CFS'', #(KVA))', null, null, null, null, null, '0000100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!S1', name='!S1 �������� ������� �� CFS/SWT  (MT 103)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_stop_op( 1 , #(REF),''CFS'', #(KVA))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='!S1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!S1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!S1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!S1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!S1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!S1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!S1';
end;
/
commit;
