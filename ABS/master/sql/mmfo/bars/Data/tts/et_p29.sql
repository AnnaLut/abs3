set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� P29
prompt ������������ ��������: P29 ��������o �� ��,���,���,���,����� + ��+�����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P29', 'P29 ��������o �� ��,���,���,���,����� + ��+�����', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P29', name='P29 ��������o �� ��,���,���,���,����� + ��+�����', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='P29';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='P29';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'P29', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''P29'', ''M'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('N2909', 'P29', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''N2909'', ''P29'', ''M'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('V2909', 'P29', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''V2909'', ''P29'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='P29';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='P29';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='P29';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='P29';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='P29';
end;
/
commit;
