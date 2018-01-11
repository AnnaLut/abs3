set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CI4
prompt ������������ ��������: CI4 ����� ����� �� ������ �������� �INTEREXPRESS� (�������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CI4', 'CI4 ����� ����� �� ������ �������� �INTEREXPRESS� (�������)', 1, '#(nbs_ob22 (''2909'',''42''))', 980, '#(nbs_ob22 (''6510'',''82''))', 980, null, '#(nbs_ob22 (''2909'',''42''))', '#(nbs_ob22 (''6510'',''82''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', '����� ����� �� ������ �������� �INTEREXPRESS� (�������), �� �������� ������� ����� ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CI4', name='CI4 ����� ����� �� ������ �������� �INTEREXPRESS� (�������)', dk=1, nlsm='#(nbs_ob22 (''2909'',''42''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''82''))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''2909'',''42''))', nlsb='#(nbs_ob22 (''6510'',''82''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='����� ����� �� ������ �������� �INTEREXPRESS� (�������), �� �������� ������� ����� '
       where tt='CI4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CI4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CI4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CI4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2909', 'CI4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2909'', ''CI4'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6110', 'CI4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''CI4'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CI4';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'CI4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''CI4'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CI4';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CI4', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CI4'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CI4';
  begin
    insert into folders_tts(idfo, tt)
    values (42, 'CI4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 42, ''CI4'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
