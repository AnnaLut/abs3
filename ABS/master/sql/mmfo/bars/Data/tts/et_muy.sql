set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MUY
prompt ������������ ��������: MUY 2909/75 - 2900/01 ��� ����.�������  (��� ,>=150 ���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUY', 'MUY 2909/75 - 2900/01 ��� ����.�������  (��� ,>=150 ���)', 1, '#(nbs_ob22 (''2909'',''75''))', null, '#(nbs_ob22 (''2900'',''01''))', null, null, '#(nbs_ob22 (''2909'',''75''))', '#(nbs_ob22 (''2900'',''01''))', null, 0, 0, 0, 0, 'F_CHECK_PAYMENT(#(REF),2)', 'F_CHECK_PAYMENT(#(REF),2)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUY', name='MUY 2909/75 - 2900/01 ��� ����.�������  (��� ,>=150 ���)', dk=1, nlsm='#(nbs_ob22 (''2909'',''75''))', kv=null, nlsk='#(nbs_ob22 (''2900'',''01''))', kvk=null, nlss=null, nlsa='#(nbs_ob22 (''2909'',''75''))', nlsb='#(nbs_ob22 (''2900'',''01''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT(#(REF),2)', s2='F_CHECK_PAYMENT(#(REF),2)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MUY';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MUY';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MUY';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MUY';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MUY';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MUY';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MUY';
end;
/
commit;
