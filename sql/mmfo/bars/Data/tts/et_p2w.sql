set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� P2W
prompt ������������ ��������: P2W ������������� ����� ��������� ���. �� �������(2924)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2W', 'P2W ������������� ����� ��������� ���. �� �������(2924)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000100000000000000000000000000', '�������� ����� �� �������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2W', name='P2W ������������� ����� ��������� ���. �� �������(2924)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000100000000000000000000000000', nazn='�������� ����� �� �������'
       where tt='P2W';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='P2W';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='P2W';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='P2W';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'P2W', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''P2W'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2924', 'P2W', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2924'', ''P2W'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='P2W';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'P2W', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''P2W'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='P2W';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='P2W';
end;
/
commit;