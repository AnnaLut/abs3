set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C68
prompt ������������ ��������: C68  ��� ������������ ����.�����.I������i� (���a 1002/02) ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C68', 'C68  ��� ������������ ����.�����.I������i� (���a 1002/02) ���', 1, null, 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', 980, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010300000000000000000000000101', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C68', name='C68  ��� ������������ ����.�����.I������i� (���a 1002/02) ���', dk=1, nlsm=null, kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', kvk=980, nlss=null, nlsa=null, nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010300000000000000000000000101', nazn=null
       where tt='C68';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C68';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C68';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C68';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C68';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C68';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'C68', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''C68'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'C68', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''C68'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C68';
end;
/
commit;
