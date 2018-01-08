set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K16
prompt ������������ ��������: d: ���������� �� ������� �������� �� ������ "������ ������"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K16', 'd: ���������� �� ������� �������� �� ������ "������ ������"', 1, null, 980, '373910300465', 980, null, null, null, null, 0, 0, 0, 0, null, null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '���������� �� ������� �������� �� ������ "������ ������"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K16', name='d: ���������� �� ������� �������� �� ������ "������ ������"', dk=1, nlsm=null, kv=980, nlsk='373910300465', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='���������� �� ������� �������� �� ������ "������ ������"'
       where tt='K16';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K16';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K16';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K16';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K16';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K16';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K16';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K16');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K16'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
