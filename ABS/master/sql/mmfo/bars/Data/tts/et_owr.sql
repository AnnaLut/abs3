set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OWE
prompt ������������ ��������: OWE ������� �� OWR  ��������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWE', 'OWE ������� �� OWR  ��������', 1, ' #(GetGlobalOption(''NLS_292427_LOCPAY''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWE', name='OWE ������� �� OWR  ��������', dk=1, nlsm=' #(GetGlobalOption(''NLS_292427_LOCPAY''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='OWE';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OWE';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OWE';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OWE';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OWE';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OWE';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OWE';
end;
/
prompt �������� / ���������� �������� OWR
prompt ������������ ��������: OWR ����� �� ���� ��������(��������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWR', 'OWR ����� �� ���� ��������(��������)', 1, null, null, ' #(GetGlobalOption(''NLS_292427_LOCPAY''))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWR', name='OWR ����� �� ���� ��������(��������)', dk=1, nlsm=null, kv=null, nlsk=' #(GetGlobalOption(''NLS_292427_LOCPAY''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='OWR';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OWR';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OWR';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('OWE', 'OWR', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''OWE'', ''OWR'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OWR';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OWR';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OWR', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''OWR'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OWR';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OWR';
end;
/
commit;
