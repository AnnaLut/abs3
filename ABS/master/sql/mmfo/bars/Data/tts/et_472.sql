

----======================    COBUMMFO-6465.     �������� �������� 472   ==================================

set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !!H
prompt ������������ ��������:  ������������ ����������  �������� �볺��� ���� >150000.00
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!H', ' ������������ ����������  �������� �볺��� ���� >150000.00', 1, null, null, null, null, null, null, null, null, 1, 0, 0, 0, 'F_STOP(80014,#(REF),'''',0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!H', name=' ������������ ����������  �������� �볺��� ���� >150000.00', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s='F_STOP(80014,#(REF),'''',0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!H';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='!!H';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!H';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!H';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='!!H';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!H';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='!!H';
  
  
end;
/

prompt �������� / ���������� �������� G86
prompt ������������ ��������: ����������� �������� ���i��� �� ���. ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G86', '����������� �������� ���i��� �� ���. ��', 1, '#(nbs_ob22 (''2902'',''06''))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000100000000000000001000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='G86', name='����������� �������� ���i��� �� ���. ��', dk=1, nlsm='#(nbs_ob22 (''2902'',''06''))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000001000000000000000100000000000000000000000000', nazn=null
       where tt='G86';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='G86';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G86';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G86';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='G86';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G86';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='G86';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'G86');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''G86'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  
end;
/

prompt �������� / ���������� �������� K86
prompt ������������ ��������: �����.�� 6510 ���i�i� �� �������� ���i��� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K86', '�����.�� 6510 ���i�i� �� �������� ���i��� ', 0, '#(nbs_ob22 (''2902'',''06''))', 980, '#(nbs_ob22 (''6510'',''26''))', 980, null, null, null, null, 0, 0, 0, 0, 'PROC_MIN_MAX ( #(S), F_DOP(#(REF),''PR068''), F_DOP(#(REF),''S_MIN''), F_DOP(#(REF),''S_MAX'') )', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='K86', name='�����.�� 6510 ���i�i� �� �������� ���i��� ', dk=0, nlsm='#(nbs_ob22 (''2902'',''06''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''26''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='PROC_MIN_MAX ( #(S), F_DOP(#(REF),''PR068''), F_DOP(#(REF),''S_MIN''), F_DOP(#(REF),''S_MAX'') )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K86';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='K86';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K86';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K86';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='K86';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K86';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='K86';
  
  
end;
/

prompt �������� / ���������� �������� 4K2
prompt ������������ ��������: �������� ������� ���i�i� �� ��. 472
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('4K2', '�������� ������� ���i�i� �� ��. 472', 0, '#(nbs_ob22 (''2902'',''06''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'PROC_MIN_MAX ( #(S), F_DOP(#(REF),''PR068''), F_DOP(#(REF),''S_MIN''), F_DOP(#(REF),''S_MAX'') )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='4K2', name='�������� ������� ���i�i� �� ��. 472', dk=0, nlsm='#(nbs_ob22 (''2902'',''06''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='PROC_MIN_MAX ( #(S), F_DOP(#(REF),''PR068''), F_DOP(#(REF),''S_MIN''), F_DOP(#(REF),''S_MAX'') )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='4K2';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='4K2';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='4K2';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='4K2';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='4K2';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='4K2';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='4K2';
  
  
end;
/

prompt �������� / ���������� �������� 472
prompt ������������ ��������: 472  ����.���.�� ���. �� �� ������, ����. (���� � ��, % ������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('472', '472  ����.���.�� ���. �� �� ������, ����. (���� � ��, % ������)', 0, '#(nbs_ob22 (''2902'',''06''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '1000100001000000000010000011000000010000000000000000000000000000', '�������� ������� ������� �� ������� �������� �����');
  exception
    when dup_val_on_index then
      update tts set
        tt='472', name='472  ����.���.�� ���. �� �� ������, ����. (���� � ��, % ������)', dk=0, nlsm='#(nbs_ob22 (''2902'',''06''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100001000000000010000011000000010000000000000000000000000000', nazn='�������� ������� ������� �� ������� �������� �����'
       where tt='472';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='472';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '472', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''472'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '472', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''472'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '472', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRES'', ''472'', ''O'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '472', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DT_R '', ''472'', ''O'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '472', 'O', 1, 2, '�������', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP '', ''472'', ''O'', 1, 2, ''�������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '472', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''472'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', '472', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''POKPO'', ''472'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('REZID', '472', 'O', 1, 13, null, 1);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''REZID'', ''472'', ''O'', 1, 13, null, 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PR068', '472', 'M', 1, -3, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PR068'', ''472'', ''M'', 1, -3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MIN', '472', 'O', 1, -2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''S_MIN'', ''472'', ''O'', 1, -2, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('S_MAX', '472', 'O', 1, -1, '0', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''S_MAX'', ''472'', ''O'', 1, -1, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='472';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('4K2', '472', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''4K2'', ''472'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('G86', '472', 1);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''G86'', ''472'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K86', '472', 1);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''K86'', ''472'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!H', '472', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!!H'', ''472'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='472';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('1001', '472', 0, '01');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1001'', ''472'', 0, ''01'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('1002', '472', 0, '01');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1002'', ''472'', 0, ''01'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2531', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2531'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2545', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2545'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2560', '472', 1, '01');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2560'', ''472'', 1, ''01'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2560', '472', 1, '03');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2560'', ''472'', 1, ''03'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2565', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2565'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2600', '472', 1, '01');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''472'', 1, ''01'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2603', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2603'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2604', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2604'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', '472', 1, '07');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''472'', 1, ''07'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2641', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2641'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2642', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2642'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2643', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2643'', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('265 ', '472', 1, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''265 '', ''472'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='472';
  begin
    insert into tts_vob(vob, tt)
    values (137, '472');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 137, ''472'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='472';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '472', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''472'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '472', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''472'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='472';
  begin
    insert into folders_tts(idfo, tt)
    values (94, '472');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 94, ''472'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
