set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� D3I
prompt ������������ ��������: D: �������� ������ �� ���� ������� ������ � I�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D3I', 'D: �������� ������ �� ���� ������� ������ � I�', 1, '#(nbs_ob22 (''3552'',''01''))', null, '#(nbs_ob22 (''6399'',''D2''))', 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', '�������� ������ �� ���� ������� ������ � I� ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='D3I', name='D: �������� ������ �� ���� ������� ������ � I�', dk=1, nlsm='#(nbs_ob22 (''3552'',''01''))', kv=null, nlsk='#(nbs_ob22 (''6399'',''D2''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='�������� ������ �� ���� ������� ������ � I� '
       where tt='D3I';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='D3I';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='D3I';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='D3I';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='D3I';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='D3I';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='D3I';
end;
/
commit;
