set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� REV
prompt ������������ ��������: ������ "�i�����" 3800
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('REV', '������ "�i�����" 3800', null, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='REV', name='������ "�i�����" 3800', dk=null, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='REV';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='REV';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='REV';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='REV';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='REV';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='REV';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='REV';
end;
/
commit;
