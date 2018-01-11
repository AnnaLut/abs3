set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DP2
prompt ������������ ��������: DP2 +���������� ���� ������ � ���.����� (�����.)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DP2', 'DP2 +���������� ���� ������ � ���.����� (�����.)', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000011000000010000000000000000000000000000', '���������� ����� ����� �������� � #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DP2', name='DP2 +���������� ���� ������ � ���.����� (�����.)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000011000000010000000000000000000000000000', nazn='���������� ����� ����� �������� � #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DP2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DP2';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DP2', 'O', 0, 1, '23', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DPTOP'', ''DP2'', ''O'', 0, 1, ''23'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TTOF1', 'DP2', 'O', 0, null, 'KBL', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''TTOF1'', ''DP2'', ''O'', 0, null, ''KBL'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DP2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DP2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DP2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DP2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''DP2'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (102, 'DP2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 102, ''DP2'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DP2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DP2', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''DP2'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DP2', 1, null, '(not exists (Select id from staff$base where  clsid > 0 and branch = ''/'' and id = userid))', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''DP2'', 1, null, ''(not exists (Select id from staff$base where  clsid > 0 and branch = ''''/'''' and id = userid))'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DP2';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DP2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''DP2'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
