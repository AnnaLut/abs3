set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OWS
prompt ������������ ��������: OWS W4. ����������� �� ������� ������� (����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OWS', 'OWS W4. ����������� �� ������� ������� (����)', 1, null, null, '#(bpk_get_transit('''',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0001100000010000000000000000000000010000000000000000000000000000', '');
  exception
    when dup_val_on_index then 
      update tts
         set tt='OWS', name='OWS W4. ����������� �� ������� ������� (����)', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit('''',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000010000000000000000000000010000000000000000000000000000', nazn=''
       where tt='OWS';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OWS';

  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OWS';

  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OWS';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'OWS', 0, '');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2909'', ''OWS'', 0, ''26'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2600', 'OWS', 1, '14');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2600'', ''OWS'', 0, ''14'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
    begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2620', 'OWS', 1, '36');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''OWS'', 0, ''36'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OWS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'OWS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''OWS'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OWS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (16, 'OWS', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 16, ''OWS'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'OWS', 2, null, 'bpk_visa30(ref, 1)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 30, ''OWS'', 2, null, ''bpk_visa30(ref, 1)=1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OWS';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'OWS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 27, ''OWS'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
