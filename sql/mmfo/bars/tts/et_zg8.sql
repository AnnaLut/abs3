set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� ZG8
prompt ������������ ��������: ZG8-�������� ���� �� �����.(�����.���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ZG8', 'ZG8-�������� ���� �� �����.(�����.���)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1101000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ZG8', name='ZG8-�������� ���� �� �����.(�����.���)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1101000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ZG8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='ZG8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='ZG8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='ZG8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='ZG8';
  begin
    insert into tts_vob(vob, tt, ord)
    values (96, 'ZG8', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 96, ''ZG8'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='ZG8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'ZG8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''ZG8'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='ZG8';
end;
/
commit;
