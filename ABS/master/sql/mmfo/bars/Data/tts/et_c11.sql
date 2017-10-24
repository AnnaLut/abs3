set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C11
prompt ������������ ��������: C11-���� ������������� ����� (������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C11', 'C11-���� ������������� ����� (������)', 2, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '1200000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C11', name='C11-���� ������������� ����� (������)', dk=2, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1200000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C11';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C11';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('�    ', 'C11', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''�    '', ''C11'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C11';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C11';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C11';
  begin
    insert into tts_vob(vob, tt, ord)
    values (7, 'C11', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 7, ''C11'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C11';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'C11', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''C11'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C11';
end;
/
commit;
