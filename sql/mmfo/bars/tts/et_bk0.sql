set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BK0
prompt ������������ ��������: BK0 ��� �� BMU D2900-K6399
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BK0', 'BK0 ��� �� BMU D2900-K6399', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_6399'',0))', null, null, null, null, null, 0, 0, 0, 0, '#(S)- FORM_MON(#(REF),''NBU'',''B_MFK'')*COUNT_MON(#(REF),#(S))-(FORM_MON(#(REF),''NBU'',''B_MFK'')*COUNT_MON(#(REF),#(S)))/6-#(S)/6', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BK0', name='BK0 ��� �� BMU D2900-K6399', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_6399'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)- FORM_MON(#(REF),''NBU'',''B_MFK'')*COUNT_MON(#(REF),#(S))-(FORM_MON(#(REF),''NBU'',''B_MFK'')*COUNT_MON(#(REF),#(S)))/6-#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BK0';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BK0';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BK0';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BK0';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BK0';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BK0';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BK0';
end;
/
commit;
