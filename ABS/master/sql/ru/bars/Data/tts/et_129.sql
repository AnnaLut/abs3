set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 129
prompt ������������ ��������: 129  ����� �� ������ �����Ͳ� ��ʲ� (135)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('129', '129  ����� �� ������ �����Ͳ� ��ʲ� (135)', 1, '#(nbs_ob22 (''6110'',''A8''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA), F_TARIF (48, #(KVA), #(NLSA), #(S) ), SYSDATE)', null, null, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='129', name='129  ����� �� ������ �����Ͳ� ��ʲ� (135)', dk=1, nlsm='#(nbs_ob22 (''6110'',''A8''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA), F_TARIF (48, #(KVA), #(NLSA), #(S) ), SYSDATE)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='129';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='129';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='129';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='129';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='129';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='129';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='129';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '129');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''129'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
