set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C4E
prompt ������������ ��������: C4E(���.CN4) ҳ�� ��������, �� �������� �� ���������� �볺��� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C4E', 'C4E(���.CN4) ҳ�� ��������, �� �������� �� ���������� �볺��� ', 1, '#(swi_get_acc(''2909''))', null, '#(swi_get_acc(''2809''))', null, null, null, null, null, 0, 0, 1, 0, 'f_swi_sum_ret(#(S))', 'f_swi_sum_ret(#(S))', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C4E', name='C4E(���.CN4) ҳ�� ��������, �� �������� �� ���������� �볺��� ', dk=1, nlsm='#(swi_get_acc(''2909''))', kv=null, nlsk='#(swi_get_acc(''2809''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='f_swi_sum_ret(#(S))', s2='f_swi_sum_ret(#(S))', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C4E';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C4E';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C4E';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C4E';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C4E';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C4E';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C4E';
end;
/
commit;
