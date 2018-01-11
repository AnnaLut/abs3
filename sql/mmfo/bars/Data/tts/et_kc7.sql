set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KC7
prompt ������������ ��������: KC7 d: ���������� �� �������� ������ ����� ������ �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KC7', 'KC7 d: ���������� �� �������� ������ ����� ������ �����', 1, '#(nbs_ob22 (''3739'',''08''))', 980, '#(nbs_ob22 (''2809'',''24''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '���������� �� �������� ������ ����� ������ �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KC7', name='KC7 d: ���������� �� �������� ������ ����� ������ �����', dk=1, nlsm='#(nbs_ob22 (''3739'',''08''))', kv=980, nlsk='#(nbs_ob22 (''2809'',''24''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='���������� �� �������� ������ ����� ������ �����'
       where tt='KC7';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KC7';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KC7';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KC7';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KC7';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KC7';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KC7';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KC7');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''KC7'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
