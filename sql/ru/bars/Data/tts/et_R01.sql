set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� R01
prompt ������������ ��������: p) R01 - ���������� ( ���� B ) ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('R01', 'p) R01 - ���������� ( ���� B ) ��', 1, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='R01', name='p) R01 - ���������� ( ���� B ) ��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010100000000000010000000000000', nazn=null
       where tt='R01';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='R01';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='R01';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='R01';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='R01';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='R01';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='R01';
end;
/
commit;
