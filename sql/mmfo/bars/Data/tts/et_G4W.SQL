set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� W46
prompt ������������ ��������: W46 ������� ��� W4O (������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W46', 'W46 ������� ��� W4O (������)', 1, null, null, '#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='W46', name='W46 ������� ��� W4O (������)', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='W46';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='W46';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='W46';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='W46';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='W46';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='W46';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='W46';
  
  
end;
/

prompt �������� / ���������� �������� !!3
prompt ������������ ��������: :STOP ! ����=����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!3', ':STOP ! ����=����', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(3,#(MFOA),'''',#(MFOB))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!3', name=':STOP ! ����=����', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(3,#(MFOA),'''',#(MFOB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!3';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='!!3';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!3';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!3';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='!!3';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!3';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='!!3';
  
  
end;
/

prompt �������� / ���������� �������� G4W
prompt ������������ ��������: G4W-�������� � 2625/2620(���������) �� ���� ������ ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G4W', 'G4W-�������� � 2625/2620(���������) �� ���� ������ ��', 1, '#(bpk_get_transit('''',''3739'',#(NLSA),#(KVA)))', 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 1, 1, 0, 0, null, null, null, null, '0', null, '0300100000000000000000000010000000000000000000000000000000000000', '�������� � ����������� ����� ��� ����������� ����� �� ����� ������� � ������ �����');
  exception
    when dup_val_on_index then
      update tts set
        tt='G4W', name='G4W-�������� � 2625/2620(���������) �� ���� ������ ��', dk=1, nlsm='#(bpk_get_transit('''',''3739'',#(NLSA),#(KVA)))', kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0300100000000000000000000010000000000000000000000000000000000000', nazn='�������� � ����������� ����� ��� ����������� ����� �� ����� ������� � ������ �����'
       where tt='G4W';
  end;
  select count(*) into cnt_ from accounts where nls='0';
  if cnt_=0 then
  
  
  
    dbms_output.put_line('���� �������� ������� 0 ������� � �������� G4W �� ����������!');
  end if;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='G4W';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G4W';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!3', 'G4W', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!!3'', ''G4W'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('W46', 'G4W', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''W46'', ''G4W'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G4W';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'G4W', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2625'', ''G4W'', 0, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'G4W', 0, '36');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''G4W'', 0, ''36'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='G4W';
  begin
    insert into tts_vob(vob, tt)
    values (1, 'G4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 1, ''G4W'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt)
    values (6, 'G4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''G4W'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G4W';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'G4W', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 30, ''G4W'', 3, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='G4W';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'G4W');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 27, ''G4W'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
