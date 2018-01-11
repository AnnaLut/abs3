set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K23
prompt ������������ ��������: K23 ����� �� ����������� ������������ �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K23', 'K23 ����� �� ����������� ������������ �����', 1, null, 980, '#(nbs_ob22 (''6514'',''35''))', 980, null, null, null, null, 0, 0, 0, 0, 'GREATEST(GL.P_ICURVAL(#(KVA),F_TARIF(123,#(KVA),#(NLSA),#(S)),SYSDATE),GL.P_ICURVAL(840,F_TARIF(123,840,#(NLSA),100),SYSDATE))', null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K23', name='K23 ����� �� ����������� ������������ �����', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6514'',''35''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GREATEST(GL.P_ICURVAL(#(KVA),F_TARIF(123,#(KVA),#(NLSA),#(S)),SYSDATE),GL.P_ICURVAL(840,F_TARIF(123,840,#(NLSA),100),SYSDATE))', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K23';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K23';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K23';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K23';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K23';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K23';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K23';
end;
/
commit;
