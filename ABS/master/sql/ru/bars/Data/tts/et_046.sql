set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 046
prompt ������������ ��������: d: ����� ������i��� ������� (S2) ������ �� ����� ���i��i
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('046', 'd: ����� ������i��� ������� (S2) ������ �� ����� ���i��i', 1, null, 980, null, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 0, 0, 1, 0, 'EQV_OBS(#(KVB),case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end,BANKDATE,1)', 'case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000010100000000000000000000000000', '����� ������i��� ������� (S2) ������ �� ����� ���i��i');
  exception
    when dup_val_on_index then 
      update tts
         set tt='046', name='d: ����� ������i��� ������� (S2) ������ �� ����� ���i��i', dk=1, nlsm=null, kv=980, nlsk=null, kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=1, flr=0, s='EQV_OBS(#(KVB),case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end,BANKDATE,1)', s2='case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000010100000000000000000000000000', nazn='����� ������i��� ������� (S2) ������ �� ����� ���i��i'
       where tt='046';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='046';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='046';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='046';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='046';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='046';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='046';
end;
/
commit;
