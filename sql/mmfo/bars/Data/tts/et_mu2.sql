set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MU2
prompt ������������ ��������: MU2 --����� 76%2902(���)-2902(���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU2', 'MU2 --����� 76%2902(���)-2902(���)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(F_TARIF_MGE(#(S)),0)*0.76', null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU2', name='MU2 --����� 76%2902(���)-2902(���)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(F_TARIF_MGE(#(S)),0)*0.76', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU2';
end;
/
commit;
