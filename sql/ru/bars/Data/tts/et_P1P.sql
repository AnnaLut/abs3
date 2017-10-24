set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� P1P
prompt ������������ ��������: p) ����������� �������������� ����� 96-98
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P1P', 'p) ����������� �������������� ����� 96-98', 1, null, null, null, null, null, null, '#(branch_usr.get_branch_param2(''NLS_9910'',0))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', '�������� ������� �������� ������ �� ���� �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='P1P', name='p) ����������� �������������� ����� 96-98', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='#(branch_usr.get_branch_param2(''NLS_9910'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='�������� ������� �������� ������ �� ���� �����'
       where tt='P1P';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='P1P';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='P1P';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='P1P';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='P1P';
  begin
    insert into tts_vob(vob, tt, ord)
    values (980, 'P1P', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 980, ''P1P'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='P1P';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'P1P', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''P1P'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='P1P';
end;
/
commit;
