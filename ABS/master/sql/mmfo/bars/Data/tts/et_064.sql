set lines 1000
set trimspool on
set serveroutput on size 1000000

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
prompt �������� / ���������� �������� K62
prompt ������������ ��������: K62 ���i�i� �� �������� ���i��� "�������I"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K62', 'K62 ���i�i� �� �������� ���i��� "�������I"', 1, '#(nbs_ob22_RNK (''3578'',''09'',#(NLSA),980))', 980, '#(nbs_ob22 (''6519'',''17''))', 980, null, null, null, null, 0, 0, 0, 0, 'case  WHEN #(KVA) = 980 THEN  F_TARIF(62, #(KVA),#(NLSA), #(S))  ELSE 0  END', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K62', name='K62 ���i�i� �� �������� ���i��� "�������I"', dk=1, nlsm='#(nbs_ob22_RNK (''3578'',''09'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6519'',''17''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='case  WHEN #(KVA) = 980 THEN  F_TARIF(62, #(KVA),#(NLSA), #(S))  ELSE 0  END', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K62';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K62';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K62';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K62';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'K62', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''K62'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K62';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K62';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K62';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K62');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K62'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� K66
prompt ������������ ��������: K66 �����. 3570 ���i�i� �� ��� �������� (����i�)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K66', 'K66 �����. 3570 ���i�i� �� ��� �������� (����i�)', 1, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', 980, '#(nbs_ob22 (''6510'',''78''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(32, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K66', name='K66 �����. 3570 ���i�i� �� ��� �������� (����i�)', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6510'',''78''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(32, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K66';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K66';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K66';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K66';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'K66', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''K66'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K66';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'K66', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 23, ''K66'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K66';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K66';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K66');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K66'') - ��������� ���� �� ������!');
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
prompt �������� / ���������� �������� 064
prompt ������������ ��������: 064-��� �������� ��� (����i�) ����.�����.I������i� (���a 1002/02)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('064', '064-��� �������� ��� (����i�) ����.�����.I������i� (���a 1002/02)', 1, null, 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', 980, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000000000000010300000000000000000000000100', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='064', name='064-��� �������� ��� (����i�) ����.�����.I������i� (���a 1002/02)', dk=1, nlsm=null, kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', kvk=980, nlss=null, nlsa=null, nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000000000000010300000000000000000000000100', nazn=null
       where tt='064';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='064';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '064', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRES'', ''064'', ''O'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '064', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''064'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '064', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DT_R '', ''064'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ED_VN', '064', 'M', 1, 0, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ED_VN'', ''064'', ''M'', 1, 0, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FACE ', '064', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FACE '', ''064'', ''O'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '064', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''064'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NB540', '064', 'M', 1, 0, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NB540'', ''064'', ''M'', 1, 0, ''0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '064', 'O', 1, 2, '�������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP '', ''064'', ''O'', 1, 2, ''�������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', '064', 'O', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''POKPO'', ''064'', ''O'', 1, 8, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='064';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!ZP', '064', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!ZP'', ''064'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K62', '064', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''K62'', ''064'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('K66', '064', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''K66'', ''064'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('��1', '064', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''��1'', ''064'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='064';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', '064', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''064'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2604', '064', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2604'', ''064'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='064';
  begin
    insert into tts_vob(vob, tt, ord)
    values (81, '064', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 81, ''064'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='064';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '064', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''064'', 3, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '064', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''064'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, '064', 2, null, 'check_visa11(REF)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''064'', 2, null, ''check_visa11(REF)=1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='064';
  begin
    insert into folders_tts(idfo, tt)
    values (91, '064');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 91, ''064'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;