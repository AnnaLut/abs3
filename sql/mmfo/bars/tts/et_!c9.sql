set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !C9
prompt ������������ ��������: STOP-�������� C9
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!C9', 'STOP-�������� C9', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_C9(#(REF))', null, null, null, null, null, '0040M0000000000000000000040M000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!C9', name='STOP-�������� C9', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_C9(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0040M0000000000000000000040M000000000000000000000000000000000000', nazn=null
       where tt='!C9';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!C9';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!C9';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!C9';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!C9';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!C9';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!C9';
end;
/
commit;
