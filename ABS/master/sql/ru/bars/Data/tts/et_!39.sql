set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !39
prompt ������������ ��������: !39 STOP-�������. �������� ��������� ������� � �����. �����. �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!39', '!39 STOP-�������. �������� ��������� ������� � �����. �����. �������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'CHECK_DESTRUCT_PASSP_VIZA(#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!39', name='!39 STOP-�������. �������� ��������� ������� � �����. �����. �������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CHECK_DESTRUCT_PASSP_VIZA(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!39';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!39';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!39';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!39';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!39';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!39';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!39';
end;
/
commit;
