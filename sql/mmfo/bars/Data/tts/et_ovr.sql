set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OVR
prompt ������������ ��������: ��������� ����������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OVR', '��������� ����������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, 10, '0000100000000000000000000000000000000100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OVR', name='��������� ����������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=10, flags='0000100000000000000000000000000000000100000000000010000000000000', nazn=null
       where tt='OVR';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OVR';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OVR';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OVR';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OVR';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OVR';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OVR';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'OVR');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''OVR'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
