set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� %15
prompt ������������ ��������: ������������� ���������� ������ �� ������� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%15', '������������� ���������� ������ �� ������� ��', 1, null, null, null, 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', 9, '0100000000000000000000000000000000000100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%15', name='������������� ���������� ������ �� ������� ��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=9, flags='0100000000000000000000000000000000000100000000000010000000000000', nazn=null
       where tt='%15';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='%15';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='%15';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='%15';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='%15';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='%15';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='%15';
  begin
    insert into folders_tts(idfo, tt)
    values (1, '%15');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''%15'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
