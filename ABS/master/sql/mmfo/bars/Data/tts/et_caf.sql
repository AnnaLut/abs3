set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !C1
prompt ������������ ��������: !C1 STOP-������� �� ���� �������� 15000,00
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!C1', '!C1 STOP-������� �� ���� �������� 15000,00', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(101,#(KVA),'''',#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!C1', name='!C1 STOP-������� �� ���� �������� 15000,00', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(101,#(KVA),'''',#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!C1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!C1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!C1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!C1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!C1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!C1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!C1';
end;
/
prompt �������� / ���������� �������� CCF
prompt ������������ ��������: CCF (���.CAF) ����� ����� �� ������ �������� �� ����."Contact" (����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CCF', 'CCF (���.CAF) ����� ����� �� ������ �������� �� ����."Contact" (����', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''6510'',''B3''))', 980, null, null, null, null, 0, 0, 0, 0, 'CAF_KOM (''CCF'',#(KVA), #(S) )', 'CAF_KOM (''CCF'',#(KVA), #(S) )', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CCF', name='CCF (���.CAF) ����� ����� �� ������ �������� �� ����."Contact" (����', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B3''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CAF_KOM (''CCF'',#(KVA), #(S) )', s2='CAF_KOM (''CCF'',#(KVA), #(S) )', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CCF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CCF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CCF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CCF';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CCF';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CCF';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CCF', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CCF'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CCF', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CCF'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CCF';
end;
/
prompt �������� / ���������� �������� CDF
prompt ������������ ��������: CDF (���.CAF) ����� ������ �� ������ �������� �� ����."Contact" (���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDF', 'CDF (���.CAF) ����� ������ �� ������ �������� �� ����."Contact" (���', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''2909'',''64''))', null, null, null, null, null, 0, 0, 1, 0, 'gl.p_icurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)', 'CAF_KOM (''CDF'',#(KVA), #(S) )', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', 'gl.p_ncurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDF', name='CDF (���.CAF) ����� ������ �� ������ �������� �� ����."Contact" (���', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''64''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='gl.p_icurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)', s2='CAF_KOM (''CDF'',#(KVA), #(S) )', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='gl.p_ncurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)'
       where tt='CDF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CDF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CDF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CDF';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CDF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CDF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CDF';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CDF';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CDF';
end;
/
prompt �������� / ���������� �������� K57
prompt ������������ ��������: K57 (���.CAF) ����� �� ������ �������� �� ������ "Contact" (�����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K57', 'K57 (���.CAF) ����� �� ������ �������� �� ������ "Contact" (�����)', 0, '#(nbs_ob22 (''2909'',''64''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'CAF_KOM (''K57'',#(KVA), #(S) )', 'CAF_KOM (''K57'',#(KVA), #(S) )', 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K57', name='K57 (���.CAF) ����� �� ������ �������� �� ������ "Contact" (�����)', dk=0, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CAF_KOM (''K57'',#(KVA), #(S) )', s2='CAF_KOM (''K57'',#(KVA), #(S) )', sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K57';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K57';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K57';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K57';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K57';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K57';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K57';
end;
/
prompt �������� / ���������� �������� CAF
prompt ������������ ��������: CAF ������ RUB ������ ��� �������� "Contact" (����� ������) � ����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CAF', 'CAF ������ RUB ������ ��� �������� "Contact" (����� ������) � ����', 0, '#(nbs_ob22 (''2909'',''64''))', 643, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 643, null, '#(nbs_ob22 (''2909'',''64''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010000000000000000000000000000', '�������� ������� ����� (RUB) ��� �������� �� ������ "CONTACT"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CAF', name='CAF ������ RUB ������ ��� �������� "Contact" (����� ������) � ����', dk=0, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=643, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=643, nlss=null, nlsa='#(nbs_ob22 (''2909'',''64''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn='�������� ������� ����� (RUB) ��� �������� �� ������ "CONTACT"'
       where tt='CAF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CAF';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRS ', 'CAF', 'M', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRS '', ''CAF'', ''M'', 1, 8, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'CAF', 'M', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''CAF'', ''M'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', 'CAF', 'M', 0, 6, '232', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''CAF'', ''M'', 0, 6, ''232'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D6#70', 'CAF', 'M', 1, 10, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D6#70'', ''CAF'', ''M'', 1, 10, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DATN ', 'CAF', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DATN '', ''CAF'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'CAF', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''CAF'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO2 ', 'CAF', 'M', 1, 11, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO2 '', ''CAF'', ''M'', 1, 11, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IDA  ', 'CAF', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''IDA  '', ''CAF'', ''O'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('META ', 'CAF', 'M', 1, 12, '�������� �������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''META '', ''CAF'', ''M'', 1, 12, ''�������� �������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NAMED', 'CAF', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NAMED'', ''CAF'', ''M'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NATIO', 'CAF', 'O', 1, 9, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NATIO'', ''CAF'', ''O'', 1, 9, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP2', 'CAF', 'O', 0, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP2'', ''CAF'', ''O'', 0, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'CAF', 'M', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''CAF'', ''M'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('REZID', 'CAF', 'M', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''REZID'', ''CAF'', ''M'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CAF';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!C1', 'CAF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!C1'', ''CAF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CCF', 'CAF', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CCF'', ''CAF'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CDF', 'CAF', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CDF'', ''CAF'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K57', 'CAF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''K57'', ''CAF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CAF';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CAF', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2909'', ''CAF'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CAF';
  begin
    insert into tts_vob(vob, tt, ord)
    values (39, 'CAF', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 39, ''CAF'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CAF';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'CAF', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''CAF'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CAF', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CAF'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CAF';
  begin
    insert into folders_tts(idfo, tt)
    values (42, 'CAF');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 42, ''CAF'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
