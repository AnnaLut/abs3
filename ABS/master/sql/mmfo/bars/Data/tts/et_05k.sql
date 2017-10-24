set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 05K
prompt ������������ ��������: 05K ����� ��� �����/������� ������ 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('05K', '05K ����� ��� �����/������� ������ ', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''2902'',''09''))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(0.02*(#(S2)))', null, 12, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '³���������� �� �� 2.0% �� ���� ������� ������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='05K', name='05K ����� ��� �����/������� ������ ', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''2902'',''09''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(0.02*(#(S2)))', s2=null, sk=12, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='³���������� �� �� 2.0% �� ���� ������� ������'
       where tt='05K';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='05K';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='05K';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='05K';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='05K';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='05K';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='05K';
  begin
    insert into folders_tts(idfo, tt)
    values (2, '05K');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''05K'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
