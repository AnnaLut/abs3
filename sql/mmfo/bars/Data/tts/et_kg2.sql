set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KG2
prompt ������������ ��������: KG2 (���.CG2) ����� �� ������ �������� �� ������ "MoneyGram"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KG2', 'KG2 (���.CG2) ����� �� ������ �������� �� ������ "MoneyGram"', 0, '#(nbs_ob22 (''2909'',''70''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(85,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KG2', name='KG2 (���.CG2) ����� �� ������ �������� �� ������ "MoneyGram"', dk=0, nlsm='#(nbs_ob22 (''2909'',''70''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(85,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KG2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KG2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KG2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KG2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KG2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KG2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KG2';
end;
/
commit;
