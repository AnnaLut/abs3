set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 099
prompt ������������ ��������: 099 ������� �� 098
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('099', '099 ������� �� 098', 1, '#(nbs_ob22 (''9618'',''05''))', 980, '#(nbs_ob22 (''9910'',''01''))', 980, null, '#(nbs_ob22 (''9618'',''05''))', '#(nbs_ob22 (''9910'',''01''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='099', name='099 ������� �� 098', dk=1, nlsm='#(nbs_ob22 (''9618'',''05''))', kv=980, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''9618'',''05''))', nlsb='#(nbs_ob22 (''9910'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='099';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='099';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='099';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='099';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='099';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='099';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='099';
end;
/
prompt �������� / ���������� �������� 098
prompt ������������ ��������: 098 �������� ������ ��������� ����. ���� �������������� ��� (���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('098', '098 �������� ������ ��������� ����. ���� �������������� ��� (���)', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1100000000000000000000000000000000000000000000000000000000000000', '�������������� ��������� �������� ������������ ���� (���) (������=980, ��������=����������� �����)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='098', name='098 �������� ������ ��������� ����. ���� �������������� ��� (���)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100000000000000000000000000000000000000000000000000000000000000', nazn='�������������� ��������� �������� ������������ ���� (���) (������=980, ��������=����������� �����)'
       where tt='098';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='098';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='098';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('099', '098', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''099'', ''098'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='098';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2924', '098', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2924'', ''098'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('7399', '098', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''7399'', ''098'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='098';
  begin
    insert into tts_vob(vob, tt, ord)
    values (50, '098', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 50, ''098'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='098';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '098', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''098'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '098', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''098'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='098';
  begin
    insert into folders_tts(idfo, tt)
    values (26, '098');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 26, ''098'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
