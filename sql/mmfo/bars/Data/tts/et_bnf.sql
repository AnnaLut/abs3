set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BNF
prompt ������������ ��������: BNF d ��������� ������� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BNF', 'BNF d ��������� ������� ��', 1, '#(NBS_OB22(''2909'',''23''))', 980, '#(NBS_OB22(''3400'',''19''))', 980, null, null, null, null, 0, 0, 0, 0, 'BNY (5 )', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BNF', name='BNF d ��������� ������� ��', dk=1, nlsm='#(NBS_OB22(''2909'',''23''))', kv=980, nlsk='#(NBS_OB22(''3400'',''19''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BNY (5 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BNF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BNF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BNF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BNF';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BNF';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BNF';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BNF';
end;
/
commit;
