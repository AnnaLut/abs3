set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� IF0
prompt ������������ ��������: IF0-�������������� ������ �� 01.01.2018
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IF0', 'IF0-�������������� ������ �� 01.01.2018', 0, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1101101000000000000000000001000000010000000000000000000000000000', '��������������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='IF0', name='IF0-�������������� ������ �� 01.01.2018', dk=0, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1101101000000000000000000001000000010000000000000000000000000000', nazn='��������������'
       where tt='IF0';
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='IF0';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='IF0';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='IF0';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='IF0';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='IF0';
end;
/
commit;