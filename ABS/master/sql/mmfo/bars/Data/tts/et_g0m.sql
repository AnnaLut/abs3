set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� G0M
prompt ������������ ��������: G0M �����.���i�i� �� �������� ���. �� ���.�����.��������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0M', 'G0M �����.���i�i� �� �������� ���. �� ���.�����.��������', 1, null, 980, '#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', 980, null, null, null, null, 0, 0, 0, 0, '0.2*#(S)', null, null, null, null, null, '0000100000000000000010000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0M', name='G0M �����.���i�i� �� �������� ���. �� ���.�����.��������', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0.2*#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000100000000000000000000000000', nazn=null
       where tt='G0M';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='G0M';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G0M';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G0M';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='G0M';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G0M';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='G0M';
end;
/
commit;