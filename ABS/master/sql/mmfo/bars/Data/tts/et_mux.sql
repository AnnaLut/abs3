set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MUX
prompt ������������ ��������: 2909/75 - 1002 - ��� ������� (��� <150 ���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUX', '2909/75 - 1002 - ��� ������� (��� <150 ���)', 1, '#(nbs_ob22 (''2909'',''75''))', null, ' #(tobopack.GetToboCASH)', null, null, '#(nbs_ob22 (''2909'',''75''))', '#(tobopack.GetToboCASH)', null, 0, 0, 0, 0, 'F_CHECK_PAYMENT(#(REF),1)', 'F_CHECK_PAYMENT(#(REF),1)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUX', name='2909/75 - 1002 - ��� ������� (��� <150 ���)', dk=1, nlsm='#(nbs_ob22 (''2909'',''75''))', kv=null, nlsk=' #(tobopack.GetToboCASH)', kvk=null, nlss=null, nlsa='#(nbs_ob22 (''2909'',''75''))', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT(#(REF),1)', s2='F_CHECK_PAYMENT(#(REF),1)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MUX';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MUX';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MUX';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MUX';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MUX';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MUX';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MUX';
end;
/
commit;
