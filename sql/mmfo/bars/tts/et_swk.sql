set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� SWK
prompt ������������ ��������: SWK-����� ������ ��102 �� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SWK', 'SWK-����� ������ ��102 �� �������', 1, null, null, '#(get_proc_nls(''L00'',#(KVA)))', null, null, null, '37391006', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SWK', name='SWK-����� ������ ��102 �� �������', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''L00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb='37391006', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='SWK';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='SWK';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#40 ', 'SWK', 'O', 1, null, '31', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#40 '', ''SWK'', ''O'', 1, null, ''31'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', 'SWK', 'O', 1, null, '999', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_B'', ''SWK'', ''O'', 1, null, ''999'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', 'SWK', 'O', 1, null, '643', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_G'', ''SWK'', ''O'', 1, null, ''643'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', 'SWK', 'O', 1, null, '2867001', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_N'', ''SWK'', ''O'', 1, null, ''2867001'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='SWK';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='SWK';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='SWK';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SWK', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''SWK'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='SWK';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'SWK', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''SWK'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SWK', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''SWK'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='SWK';
  begin
    insert into folders_tts(idfo, tt)
    values (72, 'SWK');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 72, ''SWK'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
