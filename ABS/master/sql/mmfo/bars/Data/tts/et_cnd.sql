set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CND
prompt ������������ ��������: (���.CN1) ���������� ����������� �� ���� ���� �������� � �볺���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CND', '(���.CN1) ���������� ����������� �� ���� ���� �������� � �볺���', 1, '#(swi_get_acc(''2909''))', 980, '#(swi_get_acc(''2909''))', null, null, null, null, null, 0, 0, 1, 0, 'f_swi_sum(2)', 'f_swi_sum(3)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CND', name='(���.CN1) ���������� ����������� �� ���� ���� �������� � �볺���', dk=1, nlsm='#(swi_get_acc(''2909''))', kv=980, nlsk='#(swi_get_acc(''2909''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='f_swi_sum(2)', s2='f_swi_sum(3)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CND';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CND';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CND';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CND';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CND';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CND';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CND';
end;
/
commit;
