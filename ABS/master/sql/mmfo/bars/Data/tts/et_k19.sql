set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K19
prompt ������������ ��������: K19 K���� �� �������� ��������.����� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K19', 'K19 K���� �� �������� ��������.����� ��', 1, null, 980, '#(nbs_ob22_null(''6510'',''10'',NLSBR(#(NLSA))))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(3, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', 'K���� �� �������� ��������.����� ��');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K19', name='K19 K���� �� �������� ��������.����� ��', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22_null(''6510'',''10'',NLSBR(#(NLSA))))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(3, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='K���� �� �������� ��������.����� ��'
       where tt='K19';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K19';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K19';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K19';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K19';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K19';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K19';
end;
/
commit;
