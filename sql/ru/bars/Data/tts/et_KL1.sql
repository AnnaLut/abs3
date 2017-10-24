set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KL6
prompt ������������ ��������: ����������� �� ��� �����������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KL6', '����������� �� ��� �����������', 1, '#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_klf2', null, null, null, null, 0, '0000000000000000000000100000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KL6', name='����������� �� ��� �����������', dk=1, nlsm='#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_klf2', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000000000000000000000100000000000000000000000000000000000000000', nazn=null
       where tt='KL6';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KL6';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KL6';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KL6';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KL6';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KL6';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KL6';
end;
/
prompt �������� / ���������� �������� KL1
prompt ������������ ��������: ����.�/� ������i �� "��i���-����"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KL1', '����.�/� ������i �� "��i���-����"', 1, null, null, '#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, null, '0100100000000000000000000001000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KL1', name='����.�/� ������i �� "��i���-����"', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000001000000000000000000000000000000000000', nazn=null
       where tt='KL1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KL1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KL1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('KL6', 'KL1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''KL6'', ''KL1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KL1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KL1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'KL1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 1, ''KL1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KL1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''KL1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KL1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, 'KL1', 4, null, '(((substr(nlsa,1,4) in (''2600'',''2650'',''2603'',''2530'',''2541'',''2542'',''2544'',''2545'')) and nvl(f_get_ob22(kv, nlsb), ''02'')=''04'' and kv=980 and substr(nlsb,1,4)=''1919'') or kv<>980)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 7, ''KL1'', 4, null, ''(((substr(nlsa,1,4) in (''''2600'''',''''2650'''',''''2603'''',''''2530'''',''''2541'''',''''2542'''',''''2544'''',''''2545'''')) and nvl(f_get_ob22(kv, nlsb), ''''02'''')=''''04'''' and kv=980 and substr(nlsb,1,4)=''''1919'''') or kv<>980)'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'KL1', 5, null, 'substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''KL1'', 5, null, ''substr(NLSA,1,4) in (2062, 2063, 2082, 2083, 2102, 2103, 2112, 2113, 2122, 2123, 2132, 2133)'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (25, 'KL1', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 25, ''KL1'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (38, 'KL1', 6, null, '( NLSA like ''20%'' or NLSA like ''21%'' or NLSA like ''22%'' )', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 38, ''KL1'', 6, null, ''( NLSA like ''''20%'''' or NLSA like ''''21%'''' or NLSA like ''''22%'''' )'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (62, 'KL1', 1, null, 'corp_visa_cond(ref, pdat, kv, s, mfoa, nlsa, id_a, mfob, nlsb, id_b)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 62, ''KL1'', 1, null, ''corp_visa_cond(ref, pdat, kv, s, mfoa, nlsa, id_a, mfob, nlsb, id_b)=1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KL1';
  begin
    insert into folders_tts(idfo, tt)
    values (25, 'KL1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 25, ''KL1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
