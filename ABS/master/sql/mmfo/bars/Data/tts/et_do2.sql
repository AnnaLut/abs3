set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DO2
prompt ������������ ��������: DO2 ��� �� ���� �����.������ ����� �� ������ (��������,POS-�������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DO2', 'DO2 ��� �� ���� �����.������ ����� �� ������ (��������,POS-�������', 1, null, 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, null, null, null, 0, 0, 0, 0, 'round(#(S)/6)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DO2', name='DO2 ��� �� ���� �����.������ ����� �� ������ (��������,POS-�������', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='round(#(S)/6)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DO2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DO2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DO2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DO2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DO2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DO2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DO2';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'DO2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''DO2'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
