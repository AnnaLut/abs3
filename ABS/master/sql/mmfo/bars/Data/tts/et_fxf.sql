set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� FXF
prompt ������������ ��������: FXF-FOREX ��������� FORWARD
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FXF', 'FXF-FOREX ��������� FORWARD', 1, null, null, '9900309', null, null, null, null, '300465', 0, 0, 0, 0, null, null, null, null, null, null, '0101000000000000000000000000000000000000000000000100000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FXF', name='FXF-FOREX ��������� FORWARD', dk=1, nlsm=null, kv=null, nlsk='9900309', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101000000000000000000000000000000000000000000000100000000000000', nazn=null
       where tt='FXF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='FXF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='FXF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='FXF';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='FXF';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'FXF', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 16, ''FXF'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='FXF';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (75, 'FXF', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 75, ''FXF'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='FXF';
  begin
    insert into folders_tts(idfo, tt)
    values (71, 'FXF');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 71, ''FXF'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
