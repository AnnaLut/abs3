set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� ���
prompt ������������ ��������: ����������(�������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('���', '����������(�������)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='���', name='����������(�������)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='���';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='���';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='���';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='���';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='���';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='���';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='���';
end;
/
commit;
