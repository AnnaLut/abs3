set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K46
prompt ������������ ��������: (���.PS3) ����� �� �������.�����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K46', '(���.PS3) ����� �� �������.�����', 0, null, 980, '#(nbs_ob22 (''6110'',''06''))', 980, null, null, '#(nbs_ob22 (''6110'',''06''))', null, 0, 0, 0, 0, 'F_TARIF(46, #(KVA), #(NLSA), #(S) )', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '����� �� ������������� ������� ����� ����� ���.����� �� 16/10/2008�.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K46', name='(���.PS3) ����� �� �������.�����', dk=0, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6110'',''06''))', kvk=980, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6110'',''06''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(46, #(KVA), #(NLSA), #(S) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='����� �� ������������� ������� ����� ����� ���.����� �� 16/10/2008�.'
       where tt='K46';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K46';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K46';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K46';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K46';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K46';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K46';
end;
/
commit;
