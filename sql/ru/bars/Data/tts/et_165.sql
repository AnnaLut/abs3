set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 165
prompt ������������ ��������: 165 ������ ����������� ���� (��i���) (��� 115,140,125,130)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('165', '165 ������ ����������� ���� (��i���) (��� 115,140,125,130)', 1, '#(nbs_ob22 (''9830'',''01''))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9910'',0))', null, null, '#(nbs_ob22 (''9830'',''01''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9910'',0))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='165', name='165 ������ ����������� ���� (��i���) (��� 115,140,125,130)', dk=1, nlsm='#(nbs_ob22 (''9830'',''01''))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9910'',0))', kvk=null, nlss=null, nlsa='#(nbs_ob22 (''9830'',''01''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9910'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='165';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='165';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='165';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='165';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='165';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='165';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (3, '165', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 3, ''165'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '165', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''165'', 3, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='165';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '165');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''165'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
