set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K57
prompt ������������ ��������: K57 (���.CAF) ����� �� ������ �������� �� ������ "Contact" (�����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K57', 'K57 (���.CAF) ����� �� ������ �������� �� ������ "Contact" (�����)', 0, '#(nbs_ob22 (''2909'',''64''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'CAF_KOM (''K57'',#(KVA), #(S) )', 'CAF_KOM (''K57'',#(KVA), #(S) )', 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K57', name='K57 (���.CAF) ����� �� ������ �������� �� ������ "Contact" (�����)', dk=0, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CAF_KOM (''K57'',#(KVA), #(S) )', s2='CAF_KOM (''K57'',#(KVA), #(S) )', sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K57';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K57';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K57';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K57';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K57';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K57';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K57';
end;
/
commit;
