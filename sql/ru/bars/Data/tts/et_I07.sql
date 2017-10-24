set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� I07
prompt ������������ ��������: I07 - I����� �������� ����� �i�����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('I07', 'I07 - I����� �������� ����� �i�����', 0, null, null, '#(get_proc_nls(''T0D'',#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0001100000000000000000000000000000110000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='I07', name='I07 - I����� �������� ����� �i�����', dk=0, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T0D'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000000000000000000000000000110000000000000000000000000000', nazn=null
       where tt='I07';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='I07';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D    ', 'I07', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D    '', ''I07'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='I07';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='I07';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='I07';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'I07', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 1, ''I07'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (2, 'I07', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 2, ''I07'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'I07', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''I07'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='I07';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'I07', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''I07'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'I07', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''I07'', 1, null, null, 3) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (94, 'I07', 3, null, 'bis=1', 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 94, ''I07'', 3, null, ''bis=1'', 3) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='I07';
  begin
    insert into folders_tts(idfo, tt)
    values (92, 'I07');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 92, ''I07'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
