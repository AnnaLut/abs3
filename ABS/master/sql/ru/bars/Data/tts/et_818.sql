set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 809
prompt ������������ ��������: 809 - ���� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('809', '809 - ���� �������', 1, null, null, '29003', null, null, null, null, null, 0, 0, 0, 0, '#(S)', '#(S)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='809', name='809 - ���� �������', dk=1, nlsm=null, kv=null, nlsk='29003', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2='#(S)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='809';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='809';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='809';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='809';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='809';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='809';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='809';
end;
/
prompt �������� / ���������� �������� 818
prompt ������������ ��������: 818-������ ���� ��� ��(�����.���, ����.���,��� ����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('818', '818-������ ���� ��� ��(�����.���, ����.���,��� ����)', 0, null, null, null, 980, null, null, null, '300465', 1, 0, 1, 0, null, null, null, null, null, null, '1100000000000000000000000000000000010300000000000000000000010000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='818', name='818-������ ���� ��� ��(�����.���, ����.���,��� ����)', dk=0, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1100000000000000000000000000000000010300000000000000000000010000', nazn=null
       where tt='818';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='818';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='818';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('809', '818', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''809'', ''818'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='818';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2900', '818', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2900'', ''818'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2900', '818', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2900'', ''818'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='818';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, '818', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 16, ''818'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='818';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '818', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''818'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '818', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''818'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='818';
end;
/
commit;
