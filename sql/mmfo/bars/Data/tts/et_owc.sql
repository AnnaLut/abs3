set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OWC
prompt ������������ ��������: OWC ������� �� OW9  �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWC', 'OWC ������� �� OW9  �����', 1, '#(GetGlobalOption(''NLS_373914_LOCPAYFEE''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWC', name='OWC ������� �� OW9  �����', dk=1, nlsm='#(GetGlobalOption(''NLS_373914_LOCPAYFEE''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='OWC';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OWC';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OWC';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OWC';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OWC';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OWC';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OWC';
end;
/
commit;
