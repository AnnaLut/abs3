set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� NN6
prompt ������������ ��������: NN6 �������.�� ������ ����� (����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('NN6', 'NN6 �������.�� ������ ����� (����)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0101100000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='NN6', name='NN6 �������.�� ������ ����� (����)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101100000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='NN6';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='NN6';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='NN6';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='NN6';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='NN6';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'NN6', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''NN6'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='NN6';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'NN6', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''NN6'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='NN6';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'NN6');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''NN6'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
