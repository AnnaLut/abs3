set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !CD
prompt ������������ ��������: STOP-������� �� �������� ����� �볺��� � ������ �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!CD', 'STOP-������� �� �������� ����� �볺��� � ������ �������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_DESC_EXCEPTION(#(REF),#(KVA),#(NLSA),#(NLSB))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!CD', name='STOP-������� �� �������� ����� �볺��� � ������ �������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_DESC_EXCEPTION(#(REF),#(KVA),#(NLSA),#(NLSB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!CD';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!CD';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!CD';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!CD';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!CD';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!CD';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!CD';
end;
/
commit;
