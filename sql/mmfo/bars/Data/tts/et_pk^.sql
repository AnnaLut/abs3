set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PK^
prompt ������������ ��������: p) �-����� ����������� (����.) (�������������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PK^', 'p) �-����� ����������� (����.) (�������������)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000110000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PK^', name='p) �-����� ����������� (����.) (�������������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000110000000000000000000000000', nazn=null
       where tt='PK^';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PK^';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PK^';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PK^';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PK^';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PK^', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''PK^'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PK^';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PK^';
end;
/
commit;
