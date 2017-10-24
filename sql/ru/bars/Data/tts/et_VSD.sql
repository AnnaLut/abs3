set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� VSD
prompt ������������ ��������: --������ �������  � ���  � �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VSD', '--������ �������  � ���  � �����', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010000000000000000000000000001', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VSD', name='--������ �������  � ���  � �����', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000000000000000000001', nazn=null
       where tt='VSD';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VSD';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'VSD', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''VSD'', ''M'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('VA_KC', 'VSD', 'M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''VA_KC'', ''VSD'', ''M'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VSD';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VSD';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VSD';
  begin
    insert into tts_vob(vob, tt, ord)
    values (981, 'VSD', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 981, ''VSD'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VSD';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VSD';
  begin
    insert into folders_tts(idfo, tt)
    values (93, 'VSD');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 93, ''VSD'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
