set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C06
prompt ������������ ��������: C06 ������� �� C05
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C06', 'C06 ������� �� C05', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, 32, null, null, null, '0000100001000000000001000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C06', name='C06 ������� �� C05', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=32, proc=null, s3800=null, rang=null, flags='0000100001000000000001000000000000000100000000000000000000000000', nazn=null
       where tt='C06';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C06';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C06';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C06';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C06';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C06';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C06';
end;
/
commit;
