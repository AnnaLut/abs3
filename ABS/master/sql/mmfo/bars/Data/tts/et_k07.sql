set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K07
prompt ������������ ��������: K07 ���������� �� ��������� �������� �� ������  "������ ������"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K07', 'K07 ���������� �� ��������� �������� �� ������  "������ ������"', 1, null, null, '373910300465', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '���������� �� ��������� �������� �� ������  "�������"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K07', name='K07 ���������� �� ��������� �������� �� ������  "������ ������"', dk=1, nlsm=null, kv=null, nlsk='373910300465', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='���������� �� ��������� �������� �� ������  "�������"'
       where tt='K07';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K07';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K07';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K07';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K07';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'K07', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 23, ''K07'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K07';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K07';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K07');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K07'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;