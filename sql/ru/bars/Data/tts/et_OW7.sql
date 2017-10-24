set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OW7
prompt ������������ ��������: OW7 ����� �� ���� ��������(�������������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OW7', 'OW7 ����� �� ���� ��������(�������������)', 1, null, null, '#(nbs_ob22 (''2909'',''80''))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OW7', name='OW7 ����� �� ���� ��������(�������������)', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''2909'',''80''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='OW7';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OW7';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OW7';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OW7';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OW7';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OW7', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''OW7'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OW7';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OW7';
end;
/
commit;
