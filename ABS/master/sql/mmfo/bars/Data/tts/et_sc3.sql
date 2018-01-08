set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� SC3
prompt ������������ ��������: ���������� ���� ������ � ���.����� (������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SC3', '���������� ���� ������ � ���.����� (������)', 1, null, 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300100000000000000000000000000000010000000000000000000000000000', '���������� ����� ����� �������� �  #{dpt_social.f_nazn(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SC3', name='���������� ���� ������ � ���.����� (������)', dk=1, nlsm=null, kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300100000000000000000000000000000010000000000000000000000000000', nazn='���������� ����� ����� �������� �  #{dpt_social.f_nazn(''U'',#(ND))}'
       where tt='SC3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='SC3';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SOCOP', 'SC3', 'O', 0, null, '26', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''SOCOP'', ''SC3'', ''O'', 0, null, ''26'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='SC3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='SC3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='SC3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SC3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''SC3'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (102, 'SC3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 102, ''SC3'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='SC3';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'SC3', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''SC3'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SC3', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''SC3'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='SC3';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'SC3');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''SC3'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
