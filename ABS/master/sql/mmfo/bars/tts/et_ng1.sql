set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� NG1
prompt ������������ ��������: NG1  ������� ������ � ����.��� ���'��. � ���� ����.����� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('NG1', 'NG1  ������� ������ � ����.��� ���''��. � ���� ����.����� ', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1101100000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='NG1', name='NG1  ������� ������ � ����.��� ���''��. � ���� ����.����� ', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1101100000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='NG1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='NG1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='NG1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='NG1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1811', 'NG1', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1811'', ''NG1'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3552', 'NG1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3552'', ''NG1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='NG1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'NG1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''NG1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='NG1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'NG1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''NG1'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'NG1', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''NG1'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='NG1';
  begin
    insert into folders_tts(idfo, tt)
    values (16, 'NG1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 16, ''NG1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
