set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 809
prompt ������������ ��������: 809 - ���� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('809', '809 - ���� �������', 1, null, null, '29003', null, null, null, null, null, 0, 0, 0, 0, '#(S)', '#(S)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='809', name='809 - ���� �������', dk=1, nlsm=null, kv=null, nlsk='29003', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2='#(S)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='809';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='809';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='809';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='809';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='809';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='809';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='809';
end;
/
commit;
