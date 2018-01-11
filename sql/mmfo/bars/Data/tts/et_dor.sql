set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DO1
prompt ������������ ��������: DO1 �����. ������ ����� �� ������ (��������,POS-�������) ��� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DO1', 'DO1 �����. ������ ����� �� ������ (��������,POS-�������) ��� ���', 1, null, 980, null, 980, null, null, null, null, 0, 0, 0, 0, '#(S)-round(#(S)/6)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DO1', name='DO1 �����. ������ ����� �� ������ (��������,POS-�������) ��� ���', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)-round(#(S)/6)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DO1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DO1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DO1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DO1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DO1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DO1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DO1';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'DO1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''DO1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� DO2
prompt ������������ ��������: DO2 ��� �� ���� �����.������ ����� �� ������ (��������,POS-�������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DO2', 'DO2 ��� �� ���� �����.������ ����� �� ������ (��������,POS-�������', 1, null, 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, null, null, null, 0, 0, 0, 0, 'round(#(S)/6)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DO2', name='DO2 ��� �� ���� �����.������ ����� �� ������ (��������,POS-�������', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='round(#(S)/6)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DO2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DO2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DO2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DO2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DO2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DO2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DO2';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'DO2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''DO2'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� DOR
prompt ������������ ��������: DOR  �����.������ ����� �� ������ (��������,POS-��������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DOR', 'DOR  �����.������ ����� �� ������ (��������,POS-��������)', 1, null, 980, null, 980, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1001100000000000000000000000000000010300000000000000000000000000', '����������� ������ ����� �� ������ ��������, �������� �������� (POS-��������)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DOR', name='DOR  �����.������ ����� �� ������ (��������,POS-��������)', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001100000000000000000000000000000010300000000000000000000000000', nazn='����������� ������ ����� �� ������ ��������, �������� �������� (POS-��������)'
       where tt='DOR';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DOR';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DOR';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DO1', 'DOR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''DO1'', ''DOR'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DO2', 'DOR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''DO2'', ''DOR'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DOR';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3578', 'DOR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3578'', ''DOR'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6395', 'DOR', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6395'', ''DOR'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6395', 'DOR', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6395'', ''DOR'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DOR';
  begin
    insert into tts_vob(vob, tt, ord)
    values (172, 'DOR', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 172, ''DOR'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DOR';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'DOR', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''DOR'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DOR', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''DOR'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DOR';
  begin
    insert into folders_tts(idfo, tt)
    values (26, 'DOR');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 26, ''DOR'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
