set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� W4S
prompt ������������ ��������: W4S  �������� � �������. ��� ����������� �� ����� ���. 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W4S', 'W4S  �������� � �������. ��� ����������� �� ����� ���. ', 1, null, null, '#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='W4S', name='W4S  �������� � �������. ��� ����������� �� ����� ���. ', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='W4S';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='W4S';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='W4S';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='W4S';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='W4S';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='W4S';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'W4S', 2, null, null, 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 30, ''W4S'', 2, null, null, 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='W4S';
end;
/
commit;
