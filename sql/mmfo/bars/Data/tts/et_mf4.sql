set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MF4
prompt ������������ ��������: MF4 ����������� ������� ��� ��.����� �� �������� ������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MF4', 'MF4 ����������� ������� ��� ��.����� �� �������� ������� �����', 1, '#(nbs_ob22 (''3402'',''16''))', 980, '#(nbs_ob22 (''3400'',''19''))', 980, null, '#(nbs_ob22 (''3402'',''16''))', '#(nbs_ob22 (''3400'',''19''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MF4', name='MF4 ����������� ������� ��� ��.����� �� �������� ������� �����', dk=1, nlsm='#(nbs_ob22 (''3402'',''16''))', kv=980, nlsk='#(nbs_ob22 (''3400'',''19''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''3402'',''16''))', nlsb='#(nbs_ob22 (''3400'',''19''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MF4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MF4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MF4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MF4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3400', 'MF4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3400'', ''MF4'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3402', 'MF4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3402'', ''MF4'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MF4';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'MF4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''MF4'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MF4';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MF4', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''MF4'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MF4';
  begin
    insert into folders_tts(idfo, tt)
    values (89, 'MF4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 89, ''MF4'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
