set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C4F
prompt ������������ ��������: C4F(���.CN4) ����� �������, �� �������� �� ���������� �볺��� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C4F', 'C4F(���.CN4) ����� �������, �� �������� �� ���������� �볺��� ', 1, '#(swi_get_acc(''2909''))', 980, '#(swi_get_acc(''2809''))', 980, null, null, null, null, 0, 0, 1, 0, 'f_swi_sum_ret(f_swi_sum(4))', 'f_swi_sum_ret(f_swi_sum(4))', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C4F', name='C4F(���.CN4) ����� �������, �� �������� �� ���������� �볺��� ', dk=1, nlsm='#(swi_get_acc(''2909''))', kv=980, nlsk='#(swi_get_acc(''2809''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='f_swi_sum_ret(f_swi_sum(4))', s2='f_swi_sum_ret(f_swi_sum(4))', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C4F';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C4F';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C4F';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C4F';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C4F';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C4F';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C4F';
end;
/
commit;
