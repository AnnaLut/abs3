set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !AC
prompt ������������ ��������: STOP-������� �� ����������� ������ �������� 15 �� ����. � ������� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AC', 'STOP-������� �� ����������� ������ �������� 15 �� ����. � ������� ��', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'CHECK_TIME_VISA()', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AC', name='STOP-������� �� ����������� ������ �������� 15 �� ����. � ������� ��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CHECK_TIME_VISA()', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!AC';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!AC';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!AC';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!AC';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!AC';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!AC';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!AC';
end;
/
commit;
