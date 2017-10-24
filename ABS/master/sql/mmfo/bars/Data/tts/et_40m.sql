set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 40M
prompt ������������ ��������: 40M  ������������� ����� �� ���. �������. �������� (� ����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('40M', '40M  ������������� ����� �� ���. �������. �������� (� ����', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000010000000000000000000000000000', '�� ����� ������� � ������ ���������� �������� �____ �� __________ ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='40M', name='40M  ������������� ����� �� ���. �������. �������� (� ����', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000010000000000000000000000000000', nazn='�� ����� ������� � ������ ���������� �������� �____ �� __________ '
       where tt='40M';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='40M';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='40M';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='40M';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='40M';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='40M';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '40M', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''40M'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '40M', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''40M'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='40M';
end;
/
commit;
