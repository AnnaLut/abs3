set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DPT
prompt ������������ ��������: D: ��������� ������.���� ��� �������.��������� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DPT', 'D: ��������� ������.���� ��� �������.��������� ������', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', 0, '0000100000000000000000000000000000000000000000000000000000000000', '���������� ������ ��������� ������� ��� ������������ ��������� �������� #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DPT', name='D: ��������� ������.���� ��� �������.��������� ������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=0, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='���������� ������ ��������� ������� ��� ������������ ��������� �������� #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DPT';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DPT';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DPT', 'O', 0, 1, '51', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DPTOP'', ''DPT'', ''O'', 0, 1, ''51'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DPT';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DPT';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DPT';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DPT', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''DPT'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (46, 'DPT', 2);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 46, ''DPT'', 2) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DPT';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DPT', 2, null, 'branch_edit.get_branch_parameter_ex(branch, ''NOT2VISA'', ''0'') = ''0''', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''DPT'', 2, null, ''branch_edit.get_branch_parameter_ex(branch, ''''NOT2VISA'''', ''''0'''') = ''''0'''''', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DPT', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''DPT'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DPT';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DPT');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''DPT'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
