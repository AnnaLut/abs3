set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 19E
prompt ������������ ��������: 19E ����� �� ������ ������� ���� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('19E', '19E ����� �� ������ ������� ���� ', 0, '#(nbs_ob22 (''6110'',''B1''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(58,#(KVA),#(NLSA),#(S))', null, 5, null, '#(tobopack.GetTOBOParam(''VP_10''))', null, '0100100000000000000000000000000000000000000000000000000000000000', '����� �� ����� ������� ����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='19E', name='19E ����� �� ������ ������� ���� ', dk=0, nlsm='#(nbs_ob22 (''6110'',''B1''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(58,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800='#(tobopack.GetTOBOParam(''VP_10''))', rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn='����� �� ����� ������� ����'
       where tt='19E';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='19E';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='19E';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='19E';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', '19E', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1001'', ''19E'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', '19E', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1002'', ''19E'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6110', '19E', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''6110'', ''19E'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='19E';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='19E';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='19E';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '19E');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''19E'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
