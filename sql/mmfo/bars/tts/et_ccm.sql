set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CCM
prompt ������������ ��������: CCK/��������� ������� �������(���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CCM', 'CCK/��������� ������� �������(���)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, 14, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CCM', name='CCK/��������� ������� �������(���)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=14, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CCM';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CCM';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CCM';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CCM';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CCM';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CCM';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CCM';
end;
/
commit;
