set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 126
prompt ������������ ��������: 126  ����� ��.����� �� ������ �����Ͳ� ��ʲ� USD
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('126', '126  ����� ��.����� �� ������ �����Ͳ� ��ʲ� USD', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''6510'',''A9''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA),F_TARIF_TAG(#(REF),''PO_KK'')*F_TARIF (94, #(KVA), #(NLSA), #(S) ), SYSDATE)', null, 5, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='126', name='126  ����� ��.����� �� ������ �����Ͳ� ��ʲ� USD', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''6510'',''A9''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA),F_TARIF_TAG(#(REF),''PO_KK'')*F_TARIF (94, #(KVA), #(NLSA), #(S) ), SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='126';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='126';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='126';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='126';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='126';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='126';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='126';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '126');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''126'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
