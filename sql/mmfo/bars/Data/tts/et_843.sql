set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 843
prompt ������������ ��������: 843d ���. �� 845 (���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('843', '843d ���. �� 845 (���)', 0, '#(nbs_ob22 (''6214'',''03''))', 980, null, null, null, null, null, null, 0, 1, 1, 0, 'GL.P_ICURVAL(#(KVB),#(S2),SYSDATE)', '#(S2)', null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0200000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='843', name='843d ���. �� 845 (���)', dk=0, nlsm='#(nbs_ob22 (''6214'',''03''))', kv=980, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=1, flr=0, s='GL.P_ICURVAL(#(KVB),#(S2),SYSDATE)', s2='#(S2)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0200000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='843';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='843';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='843';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='843';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='843';
  begin
    insert into tts_vob(vob, tt, ord)
    values (13, '843', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 13, ''843'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='843';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '843', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''843'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '843', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''843'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='843';
  begin
    insert into folders_tts(idfo, tt)
    values (26, '843');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 26, ''843'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (92, '843');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 92, ''843'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
