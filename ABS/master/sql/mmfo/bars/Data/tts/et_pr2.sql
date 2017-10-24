set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PR2
prompt ������������ ��������: PR2  ����������� ���������������� ��������� ��������� ����� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PR2', 'PR2  ����������� ���������������� ��������� ��������� ����� ������', 1, null, 980, null, 980, null, '#(nbs_ob22 (''9770'',''01''))', '#(nbs_ob22 (''9715'',''01''))', null, 0, 0, 0, 1, null, null, null, null, null, null, '1101100000000000000000000000000000010000000000000000000000000000', '����������� ���������������� ��������� ��������� ����� ������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='PR2', name='PR2  ����������� ���������������� ��������� ��������� ����� ������', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(nbs_ob22 (''9770'',''01''))', nlsb='#(nbs_ob22 (''9715'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1101100000000000000000000000000000010000000000000000000000000000', nazn='����������� ���������������� ��������� ��������� ����� ������'
       where tt='PR2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PR2';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PIDST', 'PR2', 'O', 1, 5, '����������� ���������������� ��������� ��������� ����� ������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PIDST'', ''PR2'', ''O'', 1, 5, ''����������� ���������������� ��������� ��������� ����� ������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PO_N1', 'PR2', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PO_N1'', ''PR2'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SUMGD', 'PR2', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''SUMGD'', ''PR2'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('VLASN', 'PR2', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''VLASN'', ''PR2'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PR2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PR2';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9715', 'PR2', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9715'', ''PR2'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9770', 'PR2', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9770'', ''PR2'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PR2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (4, 'PR2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 4, ''PR2'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PR2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'PR2', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''PR2'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PR2';
  begin
    insert into folders_tts(idfo, tt)
    values (18, 'PR2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 18, ''PR2'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
