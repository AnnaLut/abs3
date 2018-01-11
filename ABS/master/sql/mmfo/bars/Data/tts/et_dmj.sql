set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DMJ
prompt ������������ ��������: DMJ ���������� ���� ������ � ��.����� (������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DMJ', 'DMJ ���������� ���� ������ � ��.����� (������)', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, 0, '0300100000000000000000000000000000010000000000000000000000000000', '���������� ����� �������� � #{DPT�WEB.F�NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DMJ', name='DMJ ���������� ���� ������ � ��.����� (������)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0300100000000000000000000000000000010000000000000000000000000000', nazn='���������� ����� �������� � #{DPT�WEB.F�NAZN(''U'',#(ND))}'
       where tt='DMJ';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DMJ';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DMJ', 'O', 0, 1, '26', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DPTOP'', ''DMJ'', ''O'', 0, 1, ''26'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DMJ';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DMJ';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'DMJ', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''DMJ'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DMJ';
  begin
    insert into tts_vob(vob, tt, ord)
    values (2, 'DMJ', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 2, ''DMJ'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (46, 'DMJ', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 46, ''DMJ'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DMJ';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DMJ', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''DMJ'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DMJ', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''DMJ'', 1, null, null, 3) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DMJ';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DMJ');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''DMJ'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
