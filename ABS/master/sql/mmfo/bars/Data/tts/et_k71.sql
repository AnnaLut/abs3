set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K71
prompt ������������ ��������: K71 ���i�i� �� ��������� ���i��� �i� ���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K71', 'K71 ���i�i� �� ��������� ���i��� �i� ���������', 0, null, null, '#(nbs_ob22 (''6510'',''99''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(31, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K71', name='K71 ���i�i� �� ��������� ���i��� �i� ���������', dk=0, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6510'',''99''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(31, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K71';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K71';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K71';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K71';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K71';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K71';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K71';
end;
/
commit;
