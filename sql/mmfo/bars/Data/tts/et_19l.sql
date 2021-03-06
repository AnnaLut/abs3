set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 19L
prompt ������������ ��������: 19L ������ ������� �� �����. ������� ����� USD
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('19L', '19L ������ ������� �� �����. ������� ����� USD', 0, '#(nbs_ob22 (''2602'',''02''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (55, #(KVA), #(NLSA), #(S) ), BANKDATE)', null, 32, null, null, null, '0000100000000000000000000000000000010000000000100000000000000000', '������ ������� �� ����������� ������� �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='19L', name='19L ������ ������� �� �����. ������� ����� USD', dk=0, nlsm='#(nbs_ob22 (''2602'',''02''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (55, #(KVA), #(NLSA), #(S) ), BANKDATE)', s2=null, sk=32, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000100000000000000000', nazn='������ ������� �� ����������� ������� �����'
       where tt='19L';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='19L';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='19L';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='19L';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='19L';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='19L';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '19L', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''19L'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '19L', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''19L'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='19L';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '19L');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''19L'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
