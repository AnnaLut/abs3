set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KL6
prompt ������������ ��������: ����������� �� ��� �����������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KL6', '����������� �� ��� �����������', 1, '#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_klf2', null, null, null, null, 0, '0000000000000000000000100000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KL6', name='����������� �� ��� �����������', dk=1, nlsm='#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_klf2', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000000000000000000000100000000000000000000000000000000000000000', nazn=null
       where tt='KL6';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KL6';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KL6';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KL6';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KL6';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KL6';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KL6';
end;
/
commit;
