set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� RSM
prompt ������������ ��������: RSM ������������� ����� �� ������� �볺��� (�������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('RSM', 'RSM ������������� ����� �� ������� �볺��� (�������)', 1, null, null, null, null, null, null, '#nbs_ob22(''3739'', ''00'')', null, 1, 0, 0, 0, null, null, null, null, null, null, '0201100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='RSM', name='RSM ������������� ����� �� ������� �볺��� (�������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='#nbs_ob22(''3739'', ''00'')', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0201100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='RSM';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='RSM';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='RSM';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='RSM';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='RSM';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'RSM', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''RSM'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='RSM';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='RSM';
end;
/
commit;
