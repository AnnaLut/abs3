set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PK0
prompt ������������ ��������: ����� 1%
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PK0', '����� 1%', 1, '#(bpk_get_transit5(''2O'',#(NLSA),#(KVA)))', null, '#(tt.bpk_get_sep_nls6(#(NLSA),#(KVA)))', 980, null, null, null, null, 0, 0, 0, 0, 'TT.BPK_GET_SEP_SUM((CASE WHEN #(KVA)=980 THEN 18 ELSE 19 END),#(KVA),#(NLSA),#(S))', null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000000000000000000000000000000000000110000000000000000000000000', '����� �� ���������� � ����� �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='PK0', name='����� 1%', dk=1, nlsm='#(bpk_get_transit5(''2O'',#(NLSA),#(KVA)))', kv=null, nlsk='#(tt.bpk_get_sep_nls6(#(NLSA),#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='TT.BPK_GET_SEP_SUM((CASE WHEN #(KVA)=980 THEN 18 ELSE 19 END),#(KVA),#(NLSA),#(S))', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000000000000000000000000000000000000110000000000000000000000000', nazn='����� �� ���������� � ����� �����'
       where tt='PK0';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PK0';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PK0';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PK0';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PK0';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PK0';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PK0';
end;
/
commit;
