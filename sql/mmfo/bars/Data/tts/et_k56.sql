set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K56
prompt ������������ ��������: K56 (���.CAT) ����� �� ������ �������� �� ������ "Contact" (�����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K56', 'K56 (���.CAT) ����� �� ������ �������� �� ������ "Contact" (�����)', 0, '#(nbs_ob22 (''2909'',''64''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'CAT_KOM (''K56'',#(KVA), #(S) )', 'CAT_KOM (''K56'',#(KVA), #(S) )', 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K56', name='K56 (���.CAT) ����� �� ������ �������� �� ������ "Contact" (�����)', dk=0, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CAT_KOM (''K56'',#(KVA), #(S) )', s2='CAT_KOM (''K56'',#(KVA), #(S) )', sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K56';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K56';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K56';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K56';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K56';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K56';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K56';
end;
/
commit;
