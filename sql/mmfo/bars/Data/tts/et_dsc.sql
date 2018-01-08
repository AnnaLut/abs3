set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DSC
prompt ������������ ��������: ����������� ������� �� ������ ������� ���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DSC', '����������� ������� �� ������ ������� ���������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 0, '0000100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DSC', name='����������� ������� �� ������ ������� ���������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='DSC';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DSC';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DSC', 'M', 0, null, '4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DPTOP'', ''DSC'', ''M'', 0, null, ''4'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DSC';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DSC';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DSC';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DSC', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''DSC'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DSC';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DSC', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''DSC'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DSC';
  begin
    insert into folders_tts(idfo, tt)
    values (5, 'DSC');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 5, ''DSC'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
