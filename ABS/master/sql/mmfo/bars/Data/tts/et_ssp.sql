set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� SSP
prompt ������������ ��������: SSP - ������������� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SSP', 'SSP - ������������� �������', 1, null, null, '#(bpk_get_transit(''1X'',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0000000000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SSP', name='SSP - ������������� �������', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''1X'',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='SSP';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='SSP';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SK_ZB', 'SSP', 'O', 0, null, '87', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''SK_ZB'', ''SSP'', ''O'', 0, null, ''87'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='SSP';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='SSP';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='SSP';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SSP', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''SSP'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='SSP';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (23, 'SSP', 1, null, 'mfob<>''300465''', 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 23, ''SSP'', 1, null, ''mfob<>''''300465'''''', 3) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'SSP', 2, null, 'mfob=''300465''', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 30, ''SSP'', 2, null, ''mfob=''''300465'''''', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='SSP';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'SSP');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 27, ''SSP'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;