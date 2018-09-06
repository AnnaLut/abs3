set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CLK
prompt ������������ ��������: SWT->�� ����� ���� Claims Conference(��)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLK', 'SWT->�� ����� ���� Claims Conference(��)', 1, '#(get_proc_nls(''T00'',#(KVA)))', null, '19197202737', null, null, null, null, null, 0, 0, 0, 0, '225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', '�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLK', name='SWT->�� ����� ���� Claims Conference(��)', dk=1, nlsm='#(get_proc_nls(''T00'',#(KVA)))', kv=null, nlsk='19197202737', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����'
       where tt='CLK';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CLK';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CLK';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CLK';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CLK';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CLK';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CLK';
end;
/
prompt �������� / ���������� �������� CLL
prompt ������������ ��������: SWT->��. ����������� � Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLL', 'SWT->��. ����������� � Claims Conference', 1, '#(get_proc_nls(''T00'',#(KVA)))', null, '29090900056557', null, null, null, null, null, 0, 0, 0, 0, '#(S)-225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', '�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLL', name='SWT->��. ����������� � Claims Conference', dk=1, nlsm='#(get_proc_nls(''T00'',#(KVA)))', kv=null, nlsk='29090900056557', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����'
       where tt='CLL';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CLL';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CLL';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CLL';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CLL';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CLL';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CLL';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLL');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 70, ''CLL'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� CLM
prompt ������������ ��������: SWT->��. Claims Conference(��)-��������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLM', 'SWT->��. Claims Conference(��)-��������', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', '�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLM', name='SWT->��. Claims Conference(��)-��������', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����'
       where tt='CLM';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CLM';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CLM';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CLM';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CLM';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CLM';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CLM';
end;
/
prompt �������� / ���������� �������� CLG
prompt ������������ ��������: CLG-SWIFT->��. ������� c Claims Conference
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLG', 'CLG-SWIFT->��. ������� c Claims Conference', 1, null, 978, '#(get_proc_nls(''T00'',#(KVA)))', 978, null, null, '29090900056557', null, 1, 0, 0, 0, null, null, null, null, '0', null, '1000000000000000000000000000000000010300000000000000000000000000', '�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLG', name='CLG-SWIFT->��. ������� c Claims Conference', dk=1, nlsm=null, kv=978, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=978, nlss=null, nlsa=null, nlsb='29090900056557', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='1000000000000000000000000000000000010300000000000000000000000000', nazn='�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����'
       where tt='CLG';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CLG';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', 'CLG', 'M', 0, null, '840', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_G'', ''CLG'', ''M'', 0, null, ''840'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', 'CLG', 'M', 0, null, '2867001', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_N'', ''CLG'', ''M'', 0, null, ''2867001'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('n    ', 'CLG', 'M', 0, null, '�840', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''n    '', ''CLG'', ''M'', 0, null, ''�840'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('�    ', 'CLG', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''�    '', ''CLG'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CLG';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLK', 'CLG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CLK'', ''CLG'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLL', 'CLG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CLL'', ''CLG'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('CLM', 'CLG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''CLM'', ''CLG'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CLG';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CLG';
  begin
    insert into tts_vob(vob, tt, ord)
    values (74, 'CLG', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 74, ''CLG'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CLG';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CLG', 2, null, null, 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CLG'', 2, null, null, 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CLG', 1, null, null, 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CLG'', 1, null, null, 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CLG';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLG');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 70, ''CLG'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
