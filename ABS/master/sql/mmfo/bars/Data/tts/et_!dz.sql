set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !DZ
prompt ������������ ��������: !����-������� (150 ��� � ��� ��� ���� � �����.)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!DZ', '!����-������� (150 ��� � ��� ��� ���� � �����.)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(415,#(KVA),#(NLSA),#(S),#(REF))', null, null, null, null, 0, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!DZ', name='!����-������� (150 ��� � ��� ��� ���� � �����.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(415,#(KVA),#(NLSA),#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='!DZ';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!DZ';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!DZ';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!DZ';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!DZ';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!DZ';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!DZ';
end;
/
commit;
