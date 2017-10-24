set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� G04
prompt ������������ ��������: G04
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G04', 'G04 ���� ���', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0001100000000000000000000000000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='G04', name='G04 ���� ��� ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0001100000000000000000000000000000010100000000000000000000000000', nazn=null
       where tt='G04';
  end;

  delete from op_rules where tt = 'G04';
  delete from ps_tts where tt = 'G04';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2924', 'G04', 0, '30');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2924'', ''G04'', 1, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'G04', 1, '01');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''G04'', 0, ''01'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'G04', 1, '02');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''G04'', 0, ''02'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'G04', 1, '03');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''G04'', 0, ''03'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'G04', 1, '05');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''G04'', 0, ''05'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2902', 'G04', 1, '06');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2902'', ''G04'', 0, ''06'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;

  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  begin
    insert into tts_vob(vob, tt)
    values (6, 'G04');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''G04'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;

  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G04';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'G04', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''G04'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;


end;
/
begin
 insert into GERC_TTS (tt,name) values ('G04','��� ����');
exception when dup_val_on_index then null;
end;
/
commit;
/
