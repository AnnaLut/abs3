set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PK5
prompt ������������ ��������: PK5 p) �-����� ����������� (����� �� ������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PK5', 'PK5 p) �-����� ����������� (����� �� ������)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000110000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PK5', name='PK5 p) �-����� ����������� (����� �� ������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000110000000000000000000000000', nazn=null
       where tt='PK5';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PK5';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PK5';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PK5';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PK5';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PK5', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''PK5'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PK5';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PK5';
end;
/
commit;
