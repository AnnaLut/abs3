set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 812
prompt ������������ ��������: 812 - ���� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('812', '812 - ���� ���', 1, '29003', 980, null, 980, null, null, null, null, 0, 0, 0, 0, '#(S2)', '#(S2)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='812', name='812 - ���� ���', dk=1, nlsm='29003', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S2)', s2='#(S2)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='812';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='812';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='812';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='812';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='812';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='812';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='812';
end;
/
commit;
