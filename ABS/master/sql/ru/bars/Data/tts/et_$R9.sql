set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� $R9
prompt ������������ ��������: 1.9.����i����� ��:�i���i���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('$R9', '1.9.����i����� ��:�i���i���', 1, '#(f_dop(#(REF), ''O9819''))', 980, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', 980, null, null, null, null, 0, 0, 0, 0, '#(S_KIL)*100', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='$R9', name='1.9.����i����� ��:�i���i���', dk=1, nlsm='#(f_dop(#(REF), ''O9819''))', kv=980, nlsk='#(branch_usr.get_branch_param2(''NLS_9910'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S_KIL)*100', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='$R9';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='$R9';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='$R9';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='$R9';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='$R9';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='$R9';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='$R9';
end;
/
commit;
