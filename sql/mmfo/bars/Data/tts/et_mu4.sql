set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MU4
prompt ������������ ��������: --�����*24% * 30% ��������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU4', '--�����*24% * 30% ��������� �����', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.30,0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU4', name='--�����*24% * 30% ��������� �����', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.30,0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU4';
end;
/
commit;
