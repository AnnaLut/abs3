set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BK4
prompt ������������ ��������: BK4 ��� �� BMY D2900-K1001
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BK4', 'BK4 ��� �� BMY D2900-K1001', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, null, null, null, null, 0, 0, 0, 0, 'FORM_MON(#(REF),''NON'',''B_MZP'')*COUNT_MON(#(REF),#(S))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BK4', name='BK4 ��� �� BMY D2900-K1001', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='FORM_MON(#(REF),''NON'',''B_MZP'')*COUNT_MON(#(REF),#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BK4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BK4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BK4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BK4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BK4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BK4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BK4';
end;
/
commit;
