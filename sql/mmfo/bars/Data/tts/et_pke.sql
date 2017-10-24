set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PKE
prompt ������������ ��������: ����� �� ������������ ������� � �� (�������.)/ 2O-����� �� ���.����. 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PKE', '����� �� ������������ ������� � �� (�������.)/ 2O-����� �� ���.����. ', 1, '#(bpk_get_transit(''2O'',#(NLSB),#(NLSA),#(KVA)))', null, null, 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0001100000000000000000000000000000010010000000000000000000000000', '����� �� ������������ ������� � �� (�������.)/ 2O-����� �� ���.����. ');
  exception
    when dup_val_on_index then
      update tts set
        tt='PKE', name='����� �� ������������ ������� � �� (�������.)/ 2O-����� �� ���.����. ', dk=1, nlsm='#(bpk_get_transit(''2O'',#(NLSB),#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0001100000000000000000000000000000010010000000000000000000000000', nazn='����� �� ������������ ������� � �� (�������.)/ 2O-����� �� ���.����. '
       where tt='PKE';
  end;
  dbms_output.put_line('�� �������� ������� ���� ������������ ����� ������� � �������� ��� ��������: PKE ');
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='PKE';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PKE';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PKE';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2520', 'PKE', 0, '02');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2520'', ''PKE'', 0, ''02'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2542', 'PKE', 0, '01');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2542'', ''PKE'', 0, ''01'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2605', 'PKE', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2605'', ''PKE'', 0, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2625', 'PKE', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2625'', ''PKE'', 0, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2655', 'PKE', 0, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2655'', ''PKE'', 0, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('6110', 'PKE', 1, '51');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''PKE'', 1, ''51'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('6110', 'PKE', 1, '52');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''PKE'', 1, ''52'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('6110', 'PKE', 1, '53');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''PKE'', 1, ''53'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('6110', 'PKE', 1, '65');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''PKE'', 1, ''65'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('6110', 'PKE', 1, '66');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''PKE'', 1, ''66'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('6110', 'PKE', 1, '67');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''PKE'', 1, ''67'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='PKE';
  begin
    insert into tts_vob(vob, tt)
    values (16, 'PKE');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 16, ''PKE'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PKE';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'PKE', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''PKE'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'PKE', 3, null, 'bpk_visa30(ref, 0)=1', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 30, ''PKE'', 3, null, ''bpk_visa30(ref, 0)=1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='PKE';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'PKE');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 27, ''PKE'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (99, 'PKE');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 99, ''PKE'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
