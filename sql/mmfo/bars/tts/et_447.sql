set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 447
prompt ������������ ��������: �� ���� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('447', '�� ���� ���', 1, '#(#(NLSB))', 980, '36229005', 980, null, null, null, null, 0, 0, 0, 0, '#(S)/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='447', name='�� ���� ���', dk=1, nlsm='#(#(NLSB))', kv=980, nlsk='36229005', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='447';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='447';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='447';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='447';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='447';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='447';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='447';
end;
/
commit;
