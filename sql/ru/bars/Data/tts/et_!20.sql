set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !20
prompt ������������ ��������: !20 �����.���� �� ���� ����.��������.�� ������. ������.�� ���. ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!20', '!20 �����.���� �� ���� ����.��������.�� ������. ������.�� ���. ������', 1, '#(nbs_ob22 (''7399'',''08''))', null, '#(nbs_ob22 (''3622'',''23''))', null, null, '#(nbs_ob22 (''7399'',''08''))', '#(nbs_ob22 (''3622'',''23''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!20', name='!20 �����.���� �� ���� ����.��������.�� ������. ������.�� ���. ������', dk=1, nlsm='#(nbs_ob22 (''7399'',''08''))', kv=null, nlsk='#(nbs_ob22 (''3622'',''23''))', kvk=null, nlss=null, nlsa='#(nbs_ob22 (''7399'',''08''))', nlsb='#(nbs_ob22 (''3622'',''23''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!20';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!20';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!20';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!20';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3622', '!20', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3622'', ''!20'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('7399', '!20', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''7399'', ''!20'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!20';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!20';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!20';
end;
/
commit;
