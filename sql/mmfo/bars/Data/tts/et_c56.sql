set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C56
prompt ������������ ��������: (��� CNB) ����� �� ������� �� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C56', '(��� CNB) ����� �� ������� �� ������', 1, '#(#(NLSA))', null, '#(swi_get_acc(''2909''))', null, null, null, null, null, 0, 0, 0, 0, 'f_swi_sum(0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C56', name='(��� CNB) ����� �� ������� �� ������', dk=1, nlsm='#(#(NLSA))', kv=null, nlsk='#(swi_get_acc(''2909''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_swi_sum(0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C56';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C56';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C56';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C56';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C56';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C56';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C56';
end;
/
commit;
