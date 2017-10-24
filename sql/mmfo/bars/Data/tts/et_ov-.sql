set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OV-
prompt ������������ ��������: ����������� ������� �� ���.����������.�i�i�� ���������� 9129
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OV-', '����������� ������� �� ���.����������.�i�i�� ���������� 9129', 1, null, 980, '99002916', 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OV-', name='����������� ������� �� ���.����������.�i�i�� ���������� 9129', dk=1, nlsm=null, kv=980, nlsk='99002916', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='OV-';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OV-';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OV-';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OV-';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OV-';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OV-', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''OV-'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OV-';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OV-';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'OV-');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''OV-'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
