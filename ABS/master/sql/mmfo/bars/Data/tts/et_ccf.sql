set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CCF
prompt ������������ ��������: CCF (���.CAF) ����� ����� �� ������ �������� �� ����."Contact" (����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CCF', 'CCF (���.CAF) ����� ����� �� ������ �������� �� ����."Contact" (����', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''6510'',''B3''))', 980, null, null, null, null, 0, 0, 0, 0, 'CAF_KOM (''CCF'',#(KVA), #(S) )', 'CAF_KOM (''CCF'',#(KVA), #(S) )', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CCF', name='CCF (���.CAF) ����� ����� �� ������ �������� �� ����."Contact" (����', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B3''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CAF_KOM (''CCF'',#(KVA), #(S) )', s2='CAF_KOM (''CCF'',#(KVA), #(S) )', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CCF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CCF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CCF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CCF';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CCF';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CCF';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CCF', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CCF'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CCF', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CCF'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CCF';
end;
/
commit;
