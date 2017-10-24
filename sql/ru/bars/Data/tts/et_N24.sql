set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� N24
prompt ������������ ��������: N24  �����i��i�  M��O�� (����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('N24', 'N24  �����i��i�  M��O�� (����)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0101100000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='N24', name='N24  �����i��i�  M��O�� (����)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101100000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='N24';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='N24';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='N24';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='N24';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='N24';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'N24', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''N24'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='N24';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'N24', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''N24'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='N24';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'N24');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''N24'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
