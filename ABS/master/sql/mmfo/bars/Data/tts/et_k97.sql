set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K97
prompt ������������ ��������: K97 ����� �� ��� ����� ���.������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K97', 'K97 ����� �� ��� ����� ���.������', 1, null, null, null, null, null, null, '#(tobopack.GetTOBOParam(''SOC_097''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000100000000000000000', '����� �� ������������-������ �������������� ����� ����������� �����������. ��� ���');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K97', name='K97 ����� �� ��� ����� ���.������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='#(tobopack.GetTOBOParam(''SOC_097''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000100000000000000000', nazn='����� �� ������������-������ �������������� ����� ����������� �����������. ��� ���'
       where tt='K97';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K97';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K97';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K97';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K97';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K97';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K97';
end;
/
commit;
