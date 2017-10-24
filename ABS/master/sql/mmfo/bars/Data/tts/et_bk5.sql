set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BK5
prompt ������������ ��������: BK5 ��� �� BMY D2900-K3500
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BK5', 'BK5 ��� �� BMY D2900-K3500', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_3500'',0))', null, null, null, null, null, 0, 0, 0, 0, '(FORM_MON(#(REF),''NBU'',''B_MZP'')*COUNT_MON(#(REF),#(S)) - FORM_MON(#(REF),''NOM'',''B_MZP'')*COUNT_MON(#(REF),#(S)))/1.2', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BK5', name='BK5 ��� �� BMY D2900-K3500', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_3500'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(FORM_MON(#(REF),''NBU'',''B_MZP'')*COUNT_MON(#(REF),#(S)) - FORM_MON(#(REF),''NOM'',''B_MZP'')*COUNT_MON(#(REF),#(S)))/1.2', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BK5';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BK5';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BK5';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BK5';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BK5';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BK5';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BK5';
end;
/
commit;
