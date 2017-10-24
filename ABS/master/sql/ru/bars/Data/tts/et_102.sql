set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 102
prompt ������������ ��������: 102 ����� �� ������� ������� ���� � USD
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('102', '102 ����� �� ������� ������� ���� � USD', 0, '#(nbs_ob22 (''3739'',''06''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (59, #(KVA), #(NLSA), #(S) ), BANKDATE)', null, 5, null, null, null, '0000100000000000000000000000000000010000000000100000000000000000', '����� ��.����� �� ������� ������� ���� USD');
  exception
    when dup_val_on_index then 
      update tts
         set tt='102', name='102 ����� �� ������� ������� ���� � USD', dk=0, nlsm='#(nbs_ob22 (''3739'',''06''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_DOP(#(REF),''PO_KK'')*GL.P_ICURVAL( #(KVA), F_TARIF (59, #(KVA), #(NLSA), #(S) ), BANKDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000100000000000000000', nazn='����� ��.����� �� ������� ������� ���� USD'
       where tt='102';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='102';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='102';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='102';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='102';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='102';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='102';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '102');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''102'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
