set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MVN
prompt ������������ ��������: ��������� ������� �� ��������� ���������� (�������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MVN', '��������� ������� �� ��������� ���������� (�������)', 1, '#(nbs_ob22 (''7399'',''42''))', 980, '#(nbs_ob22 (''3739'',''04''))', 980, null, null, null, null, 0, 0, 0, 0, '#(S2)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MVN', name='��������� ������� �� ��������� ���������� (�������)', dk=1, nlsm='#(nbs_ob22 (''7399'',''42''))', kv=980, nlsk='#(nbs_ob22 (''3739'',''04''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S2)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MVN';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MVN';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MVN';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MVN';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MVN';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MVN';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MVN';
end;
/
prompt �������� / ���������� �������� MUN
prompt ������������ ��������: MUN-��������� ������� �� ��������� ���������� � ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUN', 'MUN-��������� ������� �� ��������� ���������� � ��', 1, '#(nbs_ob22 (''3739'',''04''))', 980, null, 980, null, '#(nbs_ob22 (''3739'',''04''))', null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1001100000000000000000000001000000010000000000000000000000000000', '��������� ������� �� ��������� ����������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUN', name='MUN-��������� ������� �� ��������� ���������� � ��', dk=1, nlsm='#(nbs_ob22 (''3739'',''04''))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(nbs_ob22 (''3739'',''04''))', nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100000000000000000000001000000010000000000000000000000000000', nazn='��������� ������� �� ��������� ����������'
       where tt='MUN';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MUN';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MUN';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MVN', 'MUN', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''MVN'', ''MUN'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MUN';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''MUN'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2628', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2628'', ''MUN'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2630', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2630'', ''MUN'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2635', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2635'', ''MUN'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2638', 'MUN', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2638'', ''MUN'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3739', 'MUN', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3739'', ''MUN'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MUN';
  begin
    insert into tts_vob(vob, tt, ord)
    values (277, 'MUN', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 277, ''MUN'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MUN';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'MUN', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''MUN'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MUN', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''MUN'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MUN';
  begin
    insert into folders_tts(idfo, tt)
    values (26, 'MUN');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 26, ''MUN'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
