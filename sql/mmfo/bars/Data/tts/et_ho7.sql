set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� HO7
prompt ������������ ��������: d: ������ ������ (��� �� 07A)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('HO7', 'd: ������ ������ (��� �� 07A)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, 12, null, null, null, '0000100001000000000001000000000000000100000000000000000000000000', '��������� ��������� ������� �� �������� ���');
  exception
    when dup_val_on_index then 
      update tts
         set tt='HO7', name='d: ������ ������ (��� �� 07A)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=12, proc=null, s3800=null, rang=null, flags='0000100001000000000001000000000000000100000000000000000000000000', nazn='��������� ��������� ������� �� �������� ���'
       where tt='HO7';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='HO7';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='HO7';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='HO7';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='HO7';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='HO7';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='HO7';
end;
/
commit;
