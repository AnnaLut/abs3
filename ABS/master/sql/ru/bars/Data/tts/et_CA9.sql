set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !C1
prompt ������������ ��������: STOP-������� �� ���� �������� 15000,00
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!C1', 'STOP-������� �� ���� �������� 15000,00', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(101,#(KVA),'''',#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!C1', name='STOP-������� �� ���� �������� 15000,00', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(101,#(KVA),'''',#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
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
prompt �������� / ���������� �������� CB9
prompt ������������ ��������: (���.CA9) ����� ������ �� ������ �������� ��� �INTEREXPRESS�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CB9', '(���.CA9) ����� ������ �� ������ �������� ��� �INTEREXPRESS�', 1, '#(nbs_ob22 (''2909'',''42''))', 980, '#(nbs_ob22 (''2909'',''42''))', 978, null, null, null, null, 0, 0, 1, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE)-(GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE))/3', 'gl.p_ncurval(#(KVA),gl.p_icurval(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),bankdate)-(gl.p_icurval(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),bankdate))/3,bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CB9', name='(���.CA9) ����� ������ �� ������ �������� ��� �INTEREXPRESS�', dk=1, nlsm='#(nbs_ob22 (''2909'',''42''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''42''))', kvk=978, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE)-(GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE))/3', s2='gl.p_ncurval(#(KVA),gl.p_icurval(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),bankdate)-(gl.p_icurval(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),bankdate))/3,bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CB9';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CB9';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CB9';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CB9';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CB9', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CB9'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CB9';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CB9';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CB9';
end;
/
prompt �������� / ���������� �������� CC9
prompt ������������ ��������: (���.CA9) ����� ����� �� ������ �������� ��� �INTEREXPRESS�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CC9', '(���.CA9) ����� ����� �� ������ �������� ��� �INTEREXPRESS�', 1, '#(nbs_ob22 (''2909'',''42''))', 980, '#(nbs_ob22 (''6110'',''82''))', 980, null, null, null, null, 0, 0, 0, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE))/3', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CC9', name='(���.CA9) ����� ����� �� ������ �������� ��� �INTEREXPRESS�', dk=1, nlsm='#(nbs_ob22 (''2909'',''42''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''82''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE))/3', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CC9';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CC9';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CC9';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CC9';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CC9';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CC9';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CC9', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CC9'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CC9', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CC9'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CC9';
end;
/
prompt �������� / ���������� �������� K44
prompt ������������ ��������: (���.CA9) ����� �� ������ �������� ��� �INTEREXPRESS�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K44', '(���.CA9) ����� �� ������ �������� ��� �INTEREXPRESS�', 0, '#(nbs_ob22 (''2909'',''42''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K44', name='(���.CA9) ����� �� ������ �������� ��� �INTEREXPRESS�', dk=0, nlsm='#(nbs_ob22 (''2909'',''42''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(44,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K44';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K44';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K44';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K44';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K44';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K44';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K44';
end;
/
prompt �������� / ���������� �������� CA9
prompt ������������ ��������: CA9 ������ EUR ������ ��� �������� �� �INTEREXPRESS� � ����.
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CA9', 'CA9 ������ EUR ������ ��� �������� �� �INTEREXPRESS� � ����.', 0, '#(nbs_ob22 (''2909'',''42''))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 978, null, '#(nbs_ob22 (''2909'',''42''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010000000000000000000000000000', '�������� ������� ����� (EUR) ��� �������� �� ������ "INTEREXPRESS"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CA9', name='CA9 ������ EUR ������ ��� �������� �� �INTEREXPRESS� � ����.', dk=0, nlsm='#(nbs_ob22 (''2909'',''42''))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=978, nlss=null, nlsa='#(nbs_ob22 (''2909'',''42''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn='�������� ������� ����� (EUR) ��� �������� �� ������ "INTEREXPRESS"'
       where tt='CA9';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CA9';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRS ', 'CA9', 'M', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRS '', ''CA9'', ''M'', 1, 8, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', 'CA9', 'M', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''CA9'', ''M'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', 'CA9', 'M', 0, 6, '232', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''CA9'', ''M'', 0, 6, ''232'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D6#70', 'CA9', 'M', 1, 10, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D6#70'', ''CA9'', ''M'', 1, 10, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DATN ', 'CA9', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DATN '', ''CA9'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'CA9', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''CA9'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO2 ', 'CA9', 'M', 1, 11, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO2 '', ''CA9'', ''M'', 1, 11, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IDA  ', 'CA9', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''IDA  '', ''CA9'', ''O'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('META ', 'CA9', 'M', 1, 12, '�������� �������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''META '', ''CA9'', ''M'', 1, 12, ''�������� �������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NAMED', 'CA9', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NAMED'', ''CA9'', ''M'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NATIO', 'CA9', 'O', 1, 9, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NATIO'', ''CA9'', ''O'', 1, 9, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP2', 'CA9', 'O', 0, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP2'', ''CA9'', ''O'', 0, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', 'CA9', 'M', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''CA9'', ''M'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('REZID', 'CA9', 'M', 1, 6, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''REZID'', ''CA9'', ''M'', 1, 6, null, 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CA9';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!C1', 'CA9', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!C1'', ''CA9'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CB9', 'CA9', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CB9'', ''CA9'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CC9', 'CA9', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CC9'', ''CA9'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K44', 'CA9', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''K44'', ''CA9'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CA9';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CA9', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2909'', ''CA9'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CA9';
  begin
    insert into tts_vob(vob, tt, ord)
    values (39, 'CA9', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 39, ''CA9'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CA9';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, 'CA9', 2, null, '(f_teller_staff (userid,s,kv)=1 and f_universal_box2(USERID)=1)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''CA9'', 2, null, ''(f_teller_staff (userid,s,kv)=1 and f_universal_box2(USERID)=1)'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CA9', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CA9'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CA9';
  begin
    insert into folders_tts(idfo, tt)
    values (42, 'CA9');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 42, ''CA9'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
