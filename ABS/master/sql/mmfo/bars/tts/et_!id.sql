set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !ID
prompt ������������ ��������: !ID ���������� ���.��������(ID)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!ID', '!ID ���������� ���.��������(ID)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_check_tag(#(REF),''PASPV'')', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!ID', name='!ID ���������� ���.��������(ID)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_check_tag(#(REF),''PASPV'')', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!ID';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!ID';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!ID';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!ID';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!ID';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!ID';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!ID';
end;
/
commit;
