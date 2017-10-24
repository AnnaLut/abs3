set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C65
prompt ������������ ��������: C65 ���i�i� ��� 065 ��� �������� 1001/02 (���ic. � 3570)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C65', 'C65 ���i�i� ��� 065 ��� �������� 1001/02 (���ic. � 3570)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''3570_UKRPOSTA'',0))', 980, '#(nbs_ob22 (''6110'',''78''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(32, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C65', name='C65 ���i�i� ��� 065 ��� �������� 1001/02 (���ic. � 3570)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''3570_UKRPOSTA'',0))', kv=980, nlsk='#(nbs_ob22 (''6110'',''78''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(32, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='C65';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C65';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C65';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C65';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'C65', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''C65'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C65';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'C65', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 23, ''C65'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C65';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C65';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'C65');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''C65'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
