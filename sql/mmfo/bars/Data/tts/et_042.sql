set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� A22
prompt ������������ ��������: d: ����� �� ����������� ��������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('A22', 'd: ����� �� ����������� ��������� �����', 1, '#(tobopack.GetToboParam(''CASH''))', 980, '#(nbs_ob22 (''6114'',''34''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='A22', name='d: ����� �� ����������� ��������� �����', dk=1, nlsm='#(tobopack.GetToboParam(''CASH''))', kv=980, nlsk='#(nbs_ob22 (''6114'',''34''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='A22';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='A22';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='A22';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='A22';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='A22';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='A22';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='A22';
end;
/
prompt �������� / ���������� �������� VPJ
prompt ������������ ��������: d: ����� ��������� ������� USD (S2) ������ �� ����� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VPJ', 'd: ����� ��������� ������� USD (S2) ������ �� ����� �����', 1, null, 840, null, 980, null, '#(tobopack.GetToboCASH)', '#(tobopack.GetToboCASH)', null, 0, 0, 1, 0, 'DECODE(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500))', 'eqv_obs(#(KVB),decode(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500)),
BANKDATE,1)', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000010000000000000010100000000000000000000000000', '����� ��������� ������� ������ �� ����� �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='VPJ', name='d: ����� ��������� ������� USD (S2) ������ �� ����� �����', dk=1, nlsm=null, kv=840, nlsk=null, kvk=980, nlss=null, nlsa='#(tobopack.GetToboCASH)', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=1, flr=0, s='DECODE(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500))', s2='eqv_obs(#(KVB),decode(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500)),
BANKDATE,1)', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000010000000000000010100000000000000000000000000', nazn='����� ��������� ������� ������ �� ����� �����'
       where tt='VPJ';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VPJ';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', 'VPJ', 'O', 0, null, '261', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''VPJ'', ''O'', 0, null, ''261'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VPJ';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VPJ';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VPJ';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VPJ';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VPJ';
end;
/
prompt �������� / ���������� �������� 042
prompt ������������ ��������: 042 ����������� ���. ���. GBP->USD (� �����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('042', '042 ����������� ���. ���. GBP->USD (� �����)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 826, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 840, null, '#(tobopack.GetToboParam(''CASH''))', '#(tobopack.GetToboParam(''CASH''))', null, 1, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000010000000000000000000000000000', '����������� ���. ���. GBP->USD (� �����)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='042', name='042 ����������� ���. ���. GBP->USD (� �����)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=826, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=840, nlss=null, nlsa='#(tobopack.GetToboParam(''CASH''))', nlsb='#(tobopack.GetToboParam(''CASH''))', mfob=null, flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn='����������� ���. ���. GBP->USD (� �����)'
       where tt='042';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='042';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRS ', '042', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRS '', ''042'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '042', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''042'', ''O'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '042', 'O', 0, 4, '276', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_B'', ''042'', ''O'', 0, 4, ''276'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '042', 'O', 0, 5, '804', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_G'', ''042'', ''O'', 0, 5, ''804'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '042', 'O', 0, 6, '2343001', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_N'', ''042'', ''O'', 0, 6, ''2343001'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KURS ', '042', 'M', 0, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KURS '', ''042'', ''M'', 0, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '042', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''042'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='042';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('A22', '042', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''A22'', ''042'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VPJ', '042', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''VPJ'', ''042'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='042';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='042';
  begin
    insert into tts_vob(vob, tt, ord)
    values (27, '042', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 27, ''042'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='042';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '042', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''042'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='042';
  begin
    insert into folders_tts(idfo, tt)
    values (12, '042');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 12, ''042'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
