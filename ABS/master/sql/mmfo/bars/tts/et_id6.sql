set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� ID6
prompt ������������ ��������: ID6 - ����������� ��������� ��� � ��� � �� (���. I11)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ID6', 'ID6 - ����������� ��������� ��� � ��� � �� (���. I11)', 1, null, null, '#(GOU_RU(2))', 980, null, null, null, null, 0, 0, 1, 0, null, 'gl.p_icurval(#(KVA),#(S),bankdate)', null, null, '3800203', null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ID6', name='ID6 - ����������� ��������� ��� � ��� � �� (���. I11)', dk=1, nlsm=null, kv=null, nlsk='#(GOU_RU(2))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2='gl.p_icurval(#(KVA),#(S),bankdate)', sk=null, proc=null, s3800='3800203', rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ID6';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='ID6';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='ID6';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='ID6';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='ID6';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='ID6';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='ID6';
end;
/
commit;
