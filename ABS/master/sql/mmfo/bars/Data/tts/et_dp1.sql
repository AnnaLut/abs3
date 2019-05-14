set lines 1000
set trimspool on
set serveroutput on size 1000000


Begin
  INSERT INTO OP_FIELD 
      ( TAG, NAME, 
        FMT, BROWSER, NOMODIFY, VSPO_CHAR, CHKR, DEFAULT_VALUE, TYPE, USE_IN_ARCH
      )
  VALUES  
      ( 'KMVIP', '������� ����� � VIP (1-���,2-ͳ)',  
        NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1 
      ); 
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

COMMIT;

---------------------------------------------------------------------

Begin
  Insert into BARS.VOB
    (VOB, NAME, FLV, REP_PREFIX)
  Values
    (480, '����� �� ������ ���. + ����.��' , 1, 'ORDER80');
EXCEPTION WHEN OTHERS THEN 
  null;
END;
/

COMMIT;

--=================================================================================================================================

prompt �������� / ���������� �������� KD9
prompt ������������ ��������: ���i�i� �� ������ �����.����� VIP-�볺��� � ���� 2620
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD9', '���i�i� �� ������ �����.����� VIP-�볺��� � ���� 2620', 1, null, null, '#(nbs_ob22 (''6510'',''J4''))', null, null, null, '#(nbs_ob22 (''6510'',''J4''))', null, 0, 0, 0, 0, 'KOMIS_DP1_VIP( #(S), #(NLSA), #(KVA), F_DOP(#(REF),''KMVIP'') )', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='KD9', name='���i�i� �� ������ �����.����� VIP-�볺��� � ���� 2620', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6510'',''J4''))', kvk=null, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6510'',''J4''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='KOMIS_DP1_VIP( #(S), #(NLSA), #(KVA), F_DOP(#(REF),''KMVIP'') )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KD9';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='KD9';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KD9';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KD9';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='KD9';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KD9';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='KD9';
  
  
end;
/

prompt �������� / ���������� �������� DP1
prompt ������������ ��������: DP1 ���������� ���� ������ � ���.����� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DP1', 'DP1 ���������� ���� ������ � ���.����� �������', 1, null, 980, null, 980, null, null, '#(tobopack.GetToboCASH)', null, 1, 0, 0, 0, null, null, 55, null, null, null, '0000100001000000000000000010000000010000000000000000000000000000', '���������� ����� ����� �������� #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then
      update tts set
        tt='DP1', name='DP1 ���������� ���� ������ � ���.����� �������', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=55, proc=null, s3800=null, rang=null, flags='0000100001000000000000000010000000010000000000000000000000000000', nazn='���������� ����� ����� �������� #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DP1';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='DP1';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', 'DP1', 'M', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRES'', ''DP1'', ''M'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_K', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ASP_K'', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_N', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ASP_N'', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_S', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ASP_S'', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'DP1', 'M', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''DP1'', ''M'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DP1', 'O', 0, 8, '21', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DPTOP'', ''DP1'', ''O'', 0, 8, ''21'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', 'DP1', 'M', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DT_R '', ''DP1'', ''M'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'DP1', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''DP1'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('HERIT', 'DP1', 'O', 0, 9, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''HERIT'', ''DP1'', ''O'', 0, 9, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_B'', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_G'', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KMVIP', 'DP1', 'O', 1, 8, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KMVIP'', ''DP1'', ''O'', 1, 8, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', 'DP1', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_N'', ''DP1'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', 'DP1', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP '', ''DP1'', ''M'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'DP1', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''DP1'', ''M'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', 'DP1', 'M', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''POKPO'', ''DP1'', ''M'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('TTOF1', 'DP1', 'O', 0, null, 'KBJ', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''TTOF1'', ''DP1'', ''O'', 0, null, ''KBJ'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DP1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KD9', 'DP1', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''KD9'', ''DP1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DP1';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='DP1';
  begin
    insert into tts_vob(vob, tt)
    values (480, 'DP1');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 480, ''DP1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DP1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'DP1', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''DP1'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DP1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''DP1'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='DP1';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DP1');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''DP1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
