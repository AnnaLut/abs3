set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !ND
prompt ������������ ��������: !ND STOP-��������(��������-�����������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!ND', '!ND STOP-��������(��������-�����������)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_ND_REZ(#(REF))', null, null, null, null, null, '0000100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!ND', name='!ND STOP-��������(��������-�����������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_ND_REZ(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='!ND';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!ND';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!ND';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!ND';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!ND';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!ND';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!ND';
end;
/
commit;
