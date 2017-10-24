set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� W4G
prompt ������������ ��������: W4. �������� � �������. ��� ����������� �� ����� ���. � ������ �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W4G', 'W4. �������� � �������. ��� ����������� �� ����� ���. � ������ �����', 1, '#(bpk_get_transit('''',''3739'',#(NLSA),#(KVA)))', 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '1300100000000000000000000010000000000000000000000000000000000000', '�������� � ����������� ����� ��� ����������� ����� �� ����� ������� � ������ �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='W4G', name='W4. �������� � �������. ��� ����������� �� ����� ���. � ������ �����', dk=1, nlsm='#(bpk_get_transit('''',''3739'',#(NLSA),#(KVA)))', kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1300100000000000000000000010000000000000000000000000000000000000', nazn='�������� � ����������� ����� ��� ����������� ����� �� ����� ������� � ������ �����'
       where tt='W4G';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='W4G';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
   delete from ttsap where tt='W4G';

  begin
    insert into ttsap(ttap, tt, dk)
    values ('W46', 'W4G', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''W46'', ''W4G'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='W4G';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2625', 'W4G', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2625'', ''W4G'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='W4G';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'W4G', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 1, ''W4G'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'W4G', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''W4G'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='W4G';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'W4G', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''W4G'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'W4G', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''W4G'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
    begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'W4G', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 30, ''W4G'', 3, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='W4G';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'W4G');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 27, ''W4G'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;


MERGE INTO BARS.OBPC_TRANS_OUT A USING
 (SELECT  '20' as TRAN_TYPE,  'W4G' as TT,  0 as DK,  'PAYFACC3' as W4_MSGCODE,  1 as PAY_FLAG  FROM DUAL) B
ON (A.TT = B.TT and A.DK = B.DK)
WHEN NOT MATCHED THEN 
INSERT (TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
VALUES (B.TRAN_TYPE, B.TT, B.DK, B.W4_MSGCODE, B.PAY_FLAG)
WHEN MATCHED THEN
UPDATE SET 
  A.TRAN_TYPE = B.TRAN_TYPE,
  A.W4_MSGCODE = B.W4_MSGCODE,
  A.PAY_FLAG = B.PAY_FLAG;

  
 begin 
  execute immediate 
    ' Insert into BARS.W4_STO_TTS (TT, DESCRIPTION)'||
    '  Values (''W4G'', ''�������� ��� �190 �� WAY4'')';
exception when dup_val_on_index then 
  null;
end;
/


COMMIT;