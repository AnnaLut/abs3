set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� O99
prompt ������������ ��������: O99 �-���� ����������������� ������ overdraft`� � 9-� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('O99', 'O99 �-���� ����������������� ������ overdraft`� � 9-� �����', 1, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BPK_KR9900'',0))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='O99', name='O99 �-���� ����������������� ������ overdraft`� � 9-� �����', dk=1, nlsm=null, kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''BPK_KR9900'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='O99';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='O99';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='O99';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='O99';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='O99';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'O99', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''O99'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='O99';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='O99';
end;
/
commit;
