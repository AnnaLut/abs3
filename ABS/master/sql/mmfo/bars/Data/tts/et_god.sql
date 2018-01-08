set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� GOD
prompt ������������ ��������: �������� � �볺��� (��)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('GOD', '�������� � �볺��� (��)', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, '#(get_zay_nls29(1))', '300465', 1, 1, 0, 0, null, null, null, null, null, null, '0301100000000000000000000000000000110000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='GOD', name='�������� � �볺��� (��)', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb='#(get_zay_nls29(1))', mfob='300465', flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0301100000000000000000000000000000110000000000000000000000000000', nazn=null
       where tt='GOD';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='GOD';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='GOD';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='GOD';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='GOD';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='GOD';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'GOD', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''GOD'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='GOD';
end;
/
commit;
