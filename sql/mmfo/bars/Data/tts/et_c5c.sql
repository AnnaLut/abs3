set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C5C
prompt ������������ ��������: C5C (���.CH5) ����� ����� �� ������ �������� ��� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C5C', 'C5C (���.CH5) ����� ����� �� ������ �������� ��� �����', 1, '#(nbs_ob22 (''2909'',''73''))', 980, '#(nbs_ob22 (''6510'',''C5''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.5533*(GL.P_ICURVAL(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),SYSDATE)))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C5C', name='C5C (���.CH5) ����� ����� �� ������ �������� ��� �����', dk=1, nlsm='#(nbs_ob22 (''2909'',''73''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''C5''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.5533*(GL.P_ICURVAL(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),SYSDATE)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C5C';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C5C';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C5C';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C5C';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C5C';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C5C';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'C5C', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''C5C'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'C5C', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''C5C'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C5C';
end;
/
commit;
