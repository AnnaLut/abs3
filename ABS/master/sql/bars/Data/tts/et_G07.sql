set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !!3
prompt ������������ ��������: :STOP ! ����=����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!3', ':STOP ! ����=����', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(3,#(MFOA),'''',#(MFOB))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!!3', name=':STOP ! ����=����', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(3,#(MFOA),'''',#(MFOB))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!3';
  end;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='!!3';
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!3';
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!3';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='!!3';
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!3';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='!!3';
  
  
end;
/

prompt �������� / ���������� �������� G07
prompt ������������ ��������: G07 ���� �������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G07', 'G07 ���� �������� �����', 0, '#(get_proc_nls(''T0D'',#(KVA)))', null, null, null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, '0', null, '1200000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='G07', name='G07 ���� �������� �����', dk=0, nlsm='#(get_proc_nls(''T0D'',#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='1200000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G07';
  end;
  select count(*) into cnt_ from accounts where nls='0';
  if cnt_=0 then
  
  
  
    dbms_output.put_line('���� �������� ������� 0 ������� � �������� G07 �� ����������!');
  end if;
  
  --------------------------------
  ---------- ��������� -----------
  --------------------------------
  delete from op_rules where tt='G07';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('�    ', 'G07', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''�    '', ''G07'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G07';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!3', 'G07', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!!3'', ''G07'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G07';
  
  --------------------------------
  ------- ���� ���������� --------
  --------------------------------
  delete from tts_vob where tt='G07';
  begin
    insert into tts_vob(vob, tt)
    values (7, 'G07');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 7, ''G07'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G07';
  
  --------------------------------
  ------------ ����� -------------
  --------------------------------
  delete from folders_tts where tt='G07';
  begin
    insert into folders_tts(idfo, tt)
    values (92, 'G07');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 92, ''G07'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;
