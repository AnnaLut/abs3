set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� GOV
prompt ������������ ��������: GOV --- ���������� �� ��ϲ��� ������ ����� ���.�������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GOV', 'GOV --- ���������� �� ��ϲ��� ������ ����� ���.�������', 0, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', 980, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', null, 0, 0, 1, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GOV', name='GOV --- ���������� �� ��ϲ��� ������ ����� ���.�������', dk=0, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', kvk=980, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''VP_1819'',0))', mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GOV';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='GOV';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='GOV';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='GOV';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='GOV';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'GOV', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 16, ''GOV'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='GOV';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'GOV', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''GOV'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='GOV';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GOV');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 20, ''GOV'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;