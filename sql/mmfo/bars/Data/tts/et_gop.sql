set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� GOP
prompt ������������ ��������: --- ������������� 1.3% �� ����� ��� �� ����.�����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GOP', '--- ������������� 1.3% �� ����� ��� �� ����.�����', 1, null, null, '2902501062', null, null, null, '2902501062', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GOP', name='--- ������������� 1.3% �� ����� ��� �� ����.�����', dk=1, nlsm=null, kv=null, nlsk='2902501062', kvk=null, nlss=null, nlsa=null, nlsb='2902501062', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010100000000000000000000000000', nazn=null
       where tt='GOP';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='GOP';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('RCK_D', 'GOP', 'O', 0, null, '1112', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''RCK_D'', ''GOP'', ''O'', 0, null, ''1112'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('RCK_K', 'GOP', 'O', 0, null, '1114', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''RCK_K'', ''GOP'', ''O'', 0, null, ''1114'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='GOP';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='GOP';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='GOP';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'GOP', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''GOP'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='GOP';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='GOP';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GOP');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 20, ''GOP'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
