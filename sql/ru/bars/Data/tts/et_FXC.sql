set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� FXC
prompt ������������ ��������: ��: ³������� �� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FXC', '��: ³������� �� ���', 1, null, null, '39293003', null, null, null, null, null, 0, 2, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FXC', name='��: ³������� �� ���', dk=1, nlsm=null, kv=null, nlsk='39293003', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=2, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='FXC';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='FXC';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='FXC';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='FXC';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='FXC';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='FXC';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='FXC';
end;
/
commit;
