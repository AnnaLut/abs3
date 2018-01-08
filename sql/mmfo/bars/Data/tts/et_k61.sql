set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K61
prompt ������������ ��������: K61 ����� �� ������� �������� ��-�� ������� � �� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K61', 'K61 ����� �� ������� �������� ��-�� ������� � �� �������', 0, '#(nbs_ob22 (''6514'',''15''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(61,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', '����� �� ������� �������� ��-�� ������� � �� �������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K61', name='K61 ����� �� ������� �������� ��-�� ������� � �� �������', dk=0, nlsm='#(nbs_ob22 (''6514'',''15''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(61,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='����� �� ������� �������� ��-�� ������� � �� �������'
       where tt='K61';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K61';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K61';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K61';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K61';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K61';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K61';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K61');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K61'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
