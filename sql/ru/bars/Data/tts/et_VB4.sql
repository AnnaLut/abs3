set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� VB4
prompt ������������ ��������: VB4 ����.����� �� ���������� � ����������� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VB4', 'VB4 ����.����� �� ���������� � ����������� �������', 1, null, 980, '#(nbs_ob22 (''6110'',''01''))', 980, null, null, null, null, 0, 0, 0, 0, '(#(S)*0.01)-(#(S)*0.01)/6', null, null, null, null, null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='VB4', name='VB4 ����.����� �� ���������� � ����������� �������', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6110'',''01''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(#(S)*0.01)-(#(S)*0.01)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='VB4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='VB4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='VB4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='VB4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='VB4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='VB4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='VB4';
  begin
    insert into folders_tts(idfo, tt)
    values (19, 'VB4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 19, ''VB4'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
