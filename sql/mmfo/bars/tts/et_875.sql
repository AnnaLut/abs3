set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 875
prompt ������������ ��������: 875 - "����" ����� City Bank
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('875', '875 - "����" ����� City Bank', 1, null, 978, '19197202737', 978, null, null, '19197202737', null, 0, 0, 0, 0, '275', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='875', name='875 - "����" ����� City Bank', dk=1, nlsm=null, kv=978, nlsk='19197202737', kvk=978, nlss=null, nlsa=null, nlsb='19197202737', mfob=null, flc=0, fli=0, flv=0, flr=0, s='275', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='875';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='875';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='875';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='875';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='875';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='875';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='875';
end;
/
commit;
