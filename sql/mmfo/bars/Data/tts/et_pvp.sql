set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PVP
prompt ������������ ��������: PVP p) ����-�������� "������.���.���"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PVP', 'PVP p) ����-�������� "������.���.���"', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000011000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PVP', name='PVP p) ����-�������� "������.���.���"', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000011000000000000', nazn=null
       where tt='PVP';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PVP';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PVP';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PVP';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PVP';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PVP';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PVP';
end;
/
commit;
