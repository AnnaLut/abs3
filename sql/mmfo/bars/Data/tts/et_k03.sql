set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K03
prompt ������������ ��������: K03 ����� �� �������� � ������� �� ����� �.143
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K03', 'K03 ����� �� �������� � ������� �� ����� �.143', 1, null, 980, '#(nbs_ob22 (''6510'',''09''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF( 3, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', 'K���� �� �������� ��������.����� � ���.�� ����� �.143');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K03', name='K03 ����� �� �������� � ������� �� ����� �.143', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''09''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF( 3, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn='K���� �� �������� ��������.����� � ���.�� ����� �.143'
       where tt='K03';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K03';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'K03', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''K03'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'K03', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''K03'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', 'K03', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP '', ''K03'', ''O'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'K03', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''K03'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', 'K03', 'M', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''POKPO'', ''K03'', ''M'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K03';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K03';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K03';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K03';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'K03', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''K03'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'K03', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''K03'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K03';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K03');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K03'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
