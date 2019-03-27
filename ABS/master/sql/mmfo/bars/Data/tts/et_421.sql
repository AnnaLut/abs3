set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 421
prompt ������������ ��������: 421 �������������� �� �������.��� ������� ���� ��������� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('421', '421 �������������� �� �������.��� ������� ���� ��������� ������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 1, null, null, null, null, null, null, '1100100000000000000000000000000000010000000000000000000000000000', '�������������� �� ��������������� ������� ������� ���� ��������� ������������� �� ������ ������������ ��������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='421', name='421 �������������� �� �������.��� ������� ���� ��������� ������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100100000000000000000000000000000010000000000000000000000000000', nazn='�������������� �� ��������������� ������� ������� ���� ��������� ������������� �� ������ ������������ ��������'
       where tt='421';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='421';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='421';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='421';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9601', '421', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9601'', ''421'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', '421', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9910'', ''421'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='421';
  begin
    insert into tts_vob(vob, tt, ord)
    values (206, '421', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 206, ''421'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='421';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '421', 2, null, '(visa_asvo(userid)=1 AND nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''421'', 2, null, ''(visa_asvo(userid)=1 AND nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0)'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '421', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''421'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='421';
  begin
    insert into folders_tts(idfo, tt)
    values (44, '421');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 44, ''421'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;