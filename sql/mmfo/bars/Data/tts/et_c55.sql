set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C55
prompt ������������ ��������: C55 (��� CNB) ����� ����� �� ������ �������� �� ������� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C55', 'C55 (��� CNB) ����� ����� �� ������ �������� �� ������� ������', 1, '#(#(NLSB))', 980, '#(nbs_ob22 (''6510'',''D8''))', 980, null, null, null, null, 0, 0, 0, 0, 'f_swi_sum(1)', 'f_swi_sum(1)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C55', name='C55 (��� CNB) ����� ����� �� ������ �������� �� ������� ������', dk=1, nlsm='#(#(NLSB))', kv=980, nlsk='#(nbs_ob22 (''6510'',''D8''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_swi_sum(1)', s2='f_swi_sum(1)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C55';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C55';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C55';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C55';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C55';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C55';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C55';
end;
/
commit;
