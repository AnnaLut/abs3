set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� GO4
prompt ������������ ��������: GO4 ��: ����������� ������ �� ��������� �� �/� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GO4', 'GO4 ��: ����������� ������ �� ��������� �� �/� �����', 1, null, null, '#(get_nls_tt(''GO4'',''NLSK''))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GO4', name='GO4 ��: ����������� ������ �� ��������� �� �/� �����', dk=1, nlsm=null, kv=null, nlsk='#(get_nls_tt(''GO4'',''NLSK''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='GO4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='GO4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='GO4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='GO4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='GO4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='GO4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='GO4';
  begin
    insert into folders_tts(idfo, tt)
    values (20, 'GO4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 20, ''GO4'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
