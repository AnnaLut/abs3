set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� P2D
prompt ������������ ��������: P2D ������� �� P2V   Internet_Banking ��������� 2620-2620
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2D', 'P2D ������� �� P2V   Internet_Banking ��������� 2620-2620', 1, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2D', name='P2D ������� �� P2V   Internet_Banking ��������� 2620-2620', dk=1, nlsm='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='P2D';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='P2D';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='P2D';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='P2D';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='P2D';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='P2D';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='P2D';
end;
/
prompt �������� / ���������� �������� P2V
prompt ������������ ��������: P2V Internet_Banking ��������� 2620-2620
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2V', 'P2V Internet_Banking ��������� 2620-2620', 1, null, null, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2V', name='P2V Internet_Banking ��������� 2620-2620', dk=1, nlsm=null, kv=null, nlsk='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='P2V';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='P2V';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='P2V';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('P2D', 'P2V', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''P2D'', ''P2V'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='P2V';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='P2V';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'P2V', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''P2V'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='P2V';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='P2V';
end;
/
commit;
