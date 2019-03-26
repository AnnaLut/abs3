set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MGR
prompt ������������ ��������: MGR -- ������ ������ �������� (��� ��������) --
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MGR', 'MGR -- ������ ������ �������� (��� ��������) --', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000200000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MGR', name='MGR -- ������ ������ �������� (��� ��������) --', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000200000000000000000000000000', nazn=null
       where tt='MGR';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MGR';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MGR';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MGR';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MGR';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MGR';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MGR';
end;
/
commit;