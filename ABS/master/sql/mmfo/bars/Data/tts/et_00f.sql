set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !$7
prompt ������������ ��������: !$7 STOP-������� �� 758 ��������� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!$7', '!$7 STOP-������� �� 758 ��������� ���', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(758,0,'''',0,#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!$7', name='!$7 STOP-������� �� 758 ��������� ���', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(758,0,'''',0,#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!$7';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!$7';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!$7';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!$7';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!$7';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!$7';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!$7';
end;
/
prompt �������� / ���������� �������� !AA
prompt ������������ ��������: !AA STOP-������� �� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AA', '!AA STOP-������� �� ������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(100,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AA', name='!AA STOP-������� �� ������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(100,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='!AA';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!AA';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!AA';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!AA';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!AA';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!AA';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!AA';
end;
/
prompt �������� / ���������� �������� !AB
prompt ������������ ��������: !AB STOP-������� �� ������/������ �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AB', '!AB STOP-������� �� ������/������ �����', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(980,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AB', name='!AB STOP-������� �� ������/������ �����', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(980,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!AB';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!AB';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!AB';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!AB';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!AB';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!AB';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!AB';
end;
/
prompt �������� / ���������� �������� !ZP
prompt ������������ ��������: !ZP STOP-�������� (��������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!ZP', '!ZP STOP-�������� (��������)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_CHECK_ZP(#(REF))', null, null, null, '0', null, '0040M0000000000000000000040M000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!ZP', name='!ZP STOP-�������� (��������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_ZP(#(REF))', s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0040M0000000000000000000040M000000000000000000000000000000000000', nazn=null
       where tt='!ZP';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!ZP';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!ZP';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!ZP';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!ZP';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!ZP';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!ZP';
end;
/
prompt �������� / ���������� �������� G0F
prompt ������������ ��������: G0F �����.�����.���i�i� �� ���.�� �i���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0F', 'G0F �����.�����.���i�i� �� ���.�� �i���������', 1, '#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_00F( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0F', name='G0F �����.�����.���i�i� �� ���.�� �i���������', dk=1, nlsm='#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_00F( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G0F';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='G0F';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G0F';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G0F';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='G0F';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G0F';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='G0F';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'G0F');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''G0F'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� K0F
prompt ������������ ��������: K0F  �����. 3570 ���i�i� �� ������� ���. �� �i���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0F', 'K0F  �����. 3570 ���i�i� �� ������� ���. �� �i���������', 1, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22 (''6510'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_00F( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0F', name='K0F  �����. 3570 ���i�i� �� ������� ���. �� �i���������', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22 (''6510'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_00F( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K0F';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K0F';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K0F';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K0F';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'K0F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''K0F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K0F';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K0F';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K0F';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K0F');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K0F'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� ��1
prompt ������������ ��������: ��1 1) ���. ��� ����  (���.� 00�)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('��1', '��1 1) ���. ��� ����  (���.� 00�)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', 980, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', null, 0, 0, 0, 0, '100', '100', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='��1', name='��1 1) ���. ��� ����  (���.� 00�)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', kvk=980, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''NLS_CHEK8'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='100', s2='100', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='��1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='��1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='��1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='��1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='��1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='��1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='��1';
end;
/
prompt �������� / ���������� �������� 00F
prompt ������������ ��������: 00F-������ ���i��� � ��.����� (���i�.112/217�����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('00F', '00F-������ ���i��� � ��.����� (���i�.112/217�����)', 1, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000000000000010300000000000000000000000100', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='00F', name='00F-������ ���i��� � ��.����� (���i�.112/217�����)', dk=1, nlsm=null, kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=null, nlss=null, nlsa=null, nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000000000000010300000000000000000000000100', nazn=null
       where tt='00F';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='00F';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '00F', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRES'', ''00F'', ''O'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '00F', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''00F'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '00F', 'O', 1, 9, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''00F'', ''O'', 1, 9, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '00F', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DT_R '', ''00F'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ED_VN', '00F', 'M', 1, 0, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ED_VN'', ''00F'', ''M'', 1, 0, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FACE ', '00F', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FACE '', ''00F'', ''O'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '00F', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''00F'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NB758', '00F', 'M', 1, -2, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NB758'', ''00F'', ''M'', 1, -2, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OP758', '00F', 'O', 1, -1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''OP758'', ''00F'', ''O'', 1, -1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '00F', 'O', 1, 2, '�������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP '', ''00F'', ''O'', 1, 2, ''�������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '00F', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''00F'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', '00F', 'O', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''POKPO'', ''00F'', ''O'', 1, 8, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('Z_CEK', '00F', 'M', 1, 0, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''Z_CEK'', ''00F'', ''M'', 1, 0, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='00F';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!$7', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!$7'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!AA', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!AA'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!AB', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!AB'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!ZP', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!ZP'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('G0F', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''G0F'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K0F', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''K0F'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('��1', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''��1'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='00F';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', '00F', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1001'', ''00F'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', '00F', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1002'', ''00F'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2520', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2520'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2530', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2530'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2604', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2604'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2650', '00F', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2650'', ''00F'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='00F';
  begin
    insert into tts_vob(vob, tt, ord)
    values (80, '00F', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 80, ''00F'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='00F';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '00F', 4, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''00F'', 4, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '00F', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''00F'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, '00F', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 7, ''00F'', 3, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, '00F', 2, null, 'check_visa11(REF)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''00F'', 2, null, ''check_visa11(REF)=1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='00F';
  begin
    insert into folders_tts(idfo, tt)
    values (91, '00F');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 91, ''00F'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
