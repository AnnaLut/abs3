set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DT0
prompt ������������ ��������: p) RT0 - �������� �� ���� � (��)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DT0', 'p) RT0 - �������� �� ���� � (��)', 0, null, null, null, null, null, null, null, null, 0, 3, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DT0', name='p) RT0 - �������� �� ���� � (��)', dk=0, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=3, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='DT0';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DT0';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DT0';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DT0';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DT0';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DT0';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DT0';
end;
/
commit;
