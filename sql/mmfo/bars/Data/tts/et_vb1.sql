set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� VB3
prompt ������������ ��������: VB3 ����.����� �� ������� � �������������� �/�����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB3', 'VB3 ����.����� �� ������� � �������������� �/�����', 1, null, 980, '#(nbs_ob22 (''6510'',''60''))', 980, null, null, null, null, 0, 0, 0, 0, '#(S)*0.06', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB3', name='VB3 ����.����� �� ������� � �������������� �/�����', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''60''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)*0.06', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VB3';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VB3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VB3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VB3';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VB3';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VB3';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB3');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 19, ''VB3'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� VB4
prompt ������������ ��������: VB4 ����.����� �� ���������� � ����������� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB4', 'VB4 ����.����� �� ���������� � ����������� �������', 1, null, 980, '#(nbs_ob22 (''6510'',''01''))', 980, null, null, null, null, 0, 0, 0, 0, '(#(S)*0.01)-(#(S)*0.01)/6', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB4', name='VB4 ����.����� �� ���������� � ����������� �������', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''01''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(#(S)*0.01)-(#(S)*0.01)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VB4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VB4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VB4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VB4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VB4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VB4';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 19, ''VB4'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� VB5
prompt ������������ ��������: VB5 ��� �� ������� ���������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB5', 'VB5 ��� �� ������� ���������� �����', 1, null, 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, null, null, null, 0, 0, 0, 0, '(#(S)*0.01)/6', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB5', name='VB5 ��� �� ������� ���������� �����', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(#(S)*0.01)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB5';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VB5';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VB5';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VB5';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VB5';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VB5';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VB5';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB5');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 19, ''VB5'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� VB1
prompt ������������ ��������: VB1 ������� ����.������ �� ����. ���.���.�����ů
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB1', 'VB1 ������� ����.������ �� ����. ���.���.�����ů', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010300000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB1', name='VB1 ������� ����.������ �� ����. ���.���.�����ů', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010300000000000000000000000000', nazn=null
       where tt='VB1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VB1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VB1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VB3', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''VB3'', ''VB1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VB4', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''VB4'', ''VB1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('VB5', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''VB5'', ''VB1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VB1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2905', 'VB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2905'', ''VB1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2905', 'VB1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2905'', ''VB1'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VB1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (22, 'VB1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 22, ''VB1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VB1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'VB1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''VB1'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VB1';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 19, ''VB1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
