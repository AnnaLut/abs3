prompt �������� / ���������� �������� VZA
prompt ������������ ��������: ϳ��������� ������ ������ ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VZA', 'ϳ��������� ������ ������ ���', 1, null, null, null, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9817'',0))','#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9910'',0))', null, 0, 0, 0, 0, null, null, null, null, null, null, '1001100001000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VZA', name='ϳ��������� ������ ������ ���', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9817'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_9910'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100001000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='VZA';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VZA';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SAGON', 'VZA', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D    '', ''VZA'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SAGOD', 'VZA', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D    '', ''VZA'', ''M'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SAGOU', 'VZA', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D    '', ''VZA'', ''M'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;

  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VZA';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9817', 'VZA', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9817'', ''VZA'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', 'VZA', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9910'', ''VZA'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VZA';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, 'VZA', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 206, ''VZA'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VZA';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'VZA', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''VZA'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'VZA', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''VZA'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VZA';
  begin
    insert into folders_tts(idfo, tt)
    values (16, 'VZA');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 16, ''VZA'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
